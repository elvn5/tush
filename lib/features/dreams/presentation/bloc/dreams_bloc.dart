import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/dream.dart';
import '../../domain/repositories/dreams_repository.dart';

part 'dreams_bloc.freezed.dart';

@freezed
@freezed
abstract class DreamsEvent with _$DreamsEvent {
  const factory DreamsEvent.started() = _Started;
  const factory DreamsEvent.loadMore() = _LoadMore;
  const factory DreamsEvent.refresh([Completer<void>? completer]) = _Refresh;
  const factory DreamsEvent.add(String text) = _Add;
  const factory DreamsEvent.searchChanged(String query) = _SearchChanged;
  const factory DreamsEvent.filterChanged({
    bool? status,
    DateTime? startDate,
    DateTime? endDate,
  }) = _FilterChanged;
  const factory DreamsEvent.delete(String id) = _Delete;
}

@freezed
abstract class DreamsState with _$DreamsState {
  const factory DreamsState.initial() = _Initial;
  const factory DreamsState.loading() = _Loading;
  const factory DreamsState.loaded({
    required List<Dream> dreams,
    String? nextCursor,
    @Default(false) bool hasReachedMax,
    @Default(false) bool isLoadingMore,
    String? searchQuery,
    bool? statusFilter,
    DateTime? startDateFilter,
    DateTime? endDateFilter,
    @Default(false) bool isAdded,
    @Default(false) bool isDeleted,
  }) = _Loaded;
  const factory DreamsState.failure(String message) = _Failure;
}

@injectable
class DreamsBloc extends Bloc<DreamsEvent, DreamsState> {
  final DreamsRepository _dreamsRepository;

  DreamsBloc(this._dreamsRepository) : super(const _Initial()) {
    on<_Started>((event, emit) async {
      emit(const _Loading());
      await _loadDreams(emit);
    });

    on<_Refresh>((event, emit) async {
      await _loadDreams(emit);
      event.completer?.complete();
    });

    on<_LoadMore>((event, emit) async {
      await state.mapOrNull(
        loaded: (state) async {
          if (state.hasReachedMax || state.isLoadingMore) return;
          emit(state.copyWith(isLoadingMore: true));
          try {
            final paginatedDreams = await _dreamsRepository.getDreams(
              cursor: state.nextCursor,
              search: state.searchQuery,
              status: state.statusFilter,
              startDate: state.startDateFilter,
              endDate: state.endDateFilter,
            );
            emit(
              state.copyWith(
                dreams: [...state.dreams, ...paginatedDreams.items],
                nextCursor: paginatedDreams.nextCursor,
                hasReachedMax: paginatedDreams.nextCursor == null,
                isLoadingMore: false,
              ),
            );
          } catch (e) {
            emit(_Failure(e.toString()));
          }
        },
      );
    });

    on<_SearchChanged>((event, emit) async {
      final currentState = state;
      if (currentState is _Loaded) {
        emit(currentState.copyWith(searchQuery: event.query));
      } else {
        emit(DreamsState.loaded(dreams: [], searchQuery: event.query));
      }
      await _loadDreams(emit);
    });

    on<_FilterChanged>((event, emit) async {
      final currentState = state;
      if (currentState is _Loaded) {
        emit(
          currentState.copyWith(
            statusFilter: event.status,
            startDateFilter: event.startDate,
            endDateFilter: event.endDate,
          ),
        );
      } else {
        emit(
          DreamsState.loaded(
            dreams: [],
            statusFilter: event.status,
            startDateFilter: event.startDate,
            endDateFilter: event.endDate,
          ),
        );
      }
      await _loadDreams(emit);
    });

    on<_Add>((event, emit) async {
      try {
        await _dreamsRepository.saveDream(event.text);

        // Optimistically update or just signal success
        if (state is _Loaded) {
          emit((state as _Loaded).copyWith(isAdded: true));
          // Reset isAdded after a frame or just let the refresh handle it?
          // If we refresh, the new state will have isAdded: false (default).
        }

        add(const _Refresh());
      } catch (e) {
        emit(_Failure(e.toString()));
      }
    });

    on<_Delete>((event, emit) async {
      try {
        await _dreamsRepository.deleteDream(event.id);
        if (state is _Loaded) {
          emit((state as _Loaded).copyWith(isDeleted: true));
        } else {
          emit(const DreamsState.loaded(dreams: [], isDeleted: true));
        }
        add(const _Refresh());
      } catch (e) {
        emit(_Failure(e.toString()));
      }
    });
  }

  Future<void> _loadDreams(Emitter<DreamsState> emit) async {
    try {
      String? searchQuery;
      bool? statusFilter;
      DateTime? startDateFilter;
      DateTime? endDateFilter;

      if (state is _Loaded) {
        final loadedState = state as _Loaded;
        searchQuery = loadedState.searchQuery;
        statusFilter = loadedState.statusFilter;
        startDateFilter = loadedState.startDateFilter;
        endDateFilter = loadedState.endDateFilter;
      }

      final paginatedDreams = await _dreamsRepository.getDreams(
        search: searchQuery,
        status: statusFilter,
        startDate: startDateFilter,
        endDate: endDateFilter,
      );

      emit(
        _Loaded(
          dreams: paginatedDreams.items,
          nextCursor: paginatedDreams.nextCursor,
          hasReachedMax: paginatedDreams.nextCursor == null,
          searchQuery: searchQuery,
          statusFilter: statusFilter,
          startDateFilter: startDateFilter,
          endDateFilter: endDateFilter,
        ),
      );

      // Polling logic for pending dreams
      if (paginatedDreams.items.any((dream) => !dream.isReady)) {
        await Future.delayed(const Duration(seconds: 5));
        if (!emit.isDone) {
          add(const _Refresh());
        }
      }
    } catch (e) {
      emit(_Failure(e.toString()));
    }
  }
}
