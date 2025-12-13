import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../data/repositories/friend_requests_repository.dart';
import '../../domain/entities/friend_user.dart';

part 'friend_requests_bloc.freezed.dart';

@freezed
abstract class FriendRequestsEvent with _$FriendRequestsEvent {
  const factory FriendRequestsEvent.load() = _Load;
  const factory FriendRequestsEvent.accept({required String senderId}) =
      _Accept;
  const factory FriendRequestsEvent.decline({required String senderId}) =
      _Decline;
}

@freezed
abstract class FriendRequestsState with _$FriendRequestsState {
  const factory FriendRequestsState.initial() = _Initial;
  const factory FriendRequestsState.loading() = _Loading;
  const factory FriendRequestsState.loaded({
    required List<FriendUser> requests,
  }) = _Loaded;
  const factory FriendRequestsState.error({required String message}) = _Error;
  const factory FriendRequestsState.accepted() = _Accepted;
  const factory FriendRequestsState.declined() = _Declined;
}

@injectable
class FriendRequestsBloc
    extends Bloc<FriendRequestsEvent, FriendRequestsState> {
  final FriendRequestsRepository _repository;

  FriendRequestsBloc(this._repository) : super(const _Initial()) {
    on<_Load>((event, emit) async {
      emit(const _Loading());
      try {
        final requests = await _repository.getFriendRequests();
        emit(_Loaded(requests: requests));
      } catch (e) {
        emit(_Error(message: e.toString()));
      }
    });

    on<_Accept>((event, emit) async {
      emit(const _Loading());
      try {
        await _repository.acceptFriendRequest(senderId: event.senderId);
        emit(const _Accepted());
      } catch (e) {
        emit(_Error(message: e.toString()));
      }
    });

    on<_Decline>((event, emit) async {
      emit(const _Loading());
      try {
        await _repository.declineFriendRequest(senderId: event.senderId);
        emit(const _Declined());
      } catch (e) {
        emit(_Error(message: e.toString()));
      }
    });
  }
}
