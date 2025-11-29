import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repositories/dreams_repository.dart';

part 'dreams_bloc.freezed.dart';

@freezed
abstract class DreamsEvent with _$DreamsEvent {
  const factory DreamsEvent.add(String text) = _Add;
}

@freezed
abstract class DreamsState with _$DreamsState {
  const factory DreamsState.initial() = _Initial;
  const factory DreamsState.loading() = _Loading;
  const factory DreamsState.success() = _Success;
  const factory DreamsState.failure(String message) = _Failure;
}

@injectable
class DreamsBloc extends Bloc<DreamsEvent, DreamsState> {
  final DreamsRepository _dreamsRepository;

  DreamsBloc(this._dreamsRepository) : super(const _Initial()) {
    on<_Add>((event, emit) async {
      emit(const _Loading());
      try {
        await _dreamsRepository.saveDream(event.text);
        emit(const _Success());
      } catch (e) {
        emit(_Failure(e.toString()));
      }
    });
  }
}
