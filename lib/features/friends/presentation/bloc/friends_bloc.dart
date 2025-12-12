import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/friend_user.dart';
import '../../domain/usecases/add_friend_use_case.dart';
import '../../domain/usecases/get_friends_use_case.dart';
import '../../domain/usecases/remove_friend_use_case.dart';
import '../../domain/usecases/search_users_use_case.dart';

part 'friends_bloc.freezed.dart';

@freezed
abstract class FriendsEvent with _$FriendsEvent {
  const factory FriendsEvent.searchUsers({required String query}) =
      _SearchUsers;
  const factory FriendsEvent.clearSearch() = _ClearSearch;
  const factory FriendsEvent.addFriend({required String friendId}) = _AddFriend;
  const factory FriendsEvent.loadFriends() = _LoadFriends;
  const factory FriendsEvent.removeFriend({required String friendId}) =
      _RemoveFriend;
}

@freezed
abstract class FriendsState with _$FriendsState {
  const factory FriendsState.initial() = _Initial;
  const factory FriendsState.searching() = _Searching;
  const factory FriendsState.searchResults({required List<FriendUser> users}) =
      _SearchResults;
  const factory FriendsState.empty() = _Empty;
  const factory FriendsState.error({required String message}) = _Error;
  const factory FriendsState.addingFriend() = _AddingFriend;
  const factory FriendsState.friendAdded() = _FriendAdded;
  const factory FriendsState.loadingFriends() = _LoadingFriends;
  const factory FriendsState.friendsLoaded({
    required List<FriendUser> friends,
  }) = _FriendsLoaded;
  const factory FriendsState.friendRemoved() = _FriendRemoved;
}

@injectable
class FriendsBloc extends Bloc<FriendsEvent, FriendsState> {
  final SearchUsersUseCase _searchUsersUseCase;
  final AddFriendUseCase _addFriendUseCase;
  final GetFriendsUseCase _getFriendsUseCase;
  final RemoveFriendUseCase _removeFriendUseCase;

  FriendsBloc(
    this._searchUsersUseCase,
    this._addFriendUseCase,
    this._getFriendsUseCase,
    this._removeFriendUseCase,
  ) : super(const _Initial()) {
    on<_SearchUsers>((event, emit) async {
      if (event.query.trim().length < 2) {
        emit(const _Initial());
        return;
      }

      emit(const _Searching());
      try {
        final users = await _searchUsersUseCase(query: event.query);
        if (users.isEmpty) {
          emit(const _Empty());
        } else {
          safePrint(users);
          emit(_SearchResults(users: users));
        }
      } catch (e) {
        emit(_Error(message: e.toString()));
      }
    });

    on<_ClearSearch>((event, emit) {
      emit(const _Initial());
    });

    on<_AddFriend>((event, emit) async {
      emit(const _AddingFriend());
      try {
        await _addFriendUseCase(friendId: event.friendId);
        emit(const _FriendAdded());
      } catch (e) {
        emit(_Error(message: e.toString()));
      }
    });

    on<_LoadFriends>((event, emit) async {
      emit(const _LoadingFriends());
      try {
        final friends = await _getFriendsUseCase();
        emit(_FriendsLoaded(friends: friends));
      } catch (e) {
        emit(_Error(message: e.toString()));
      }
    });

    on<_RemoveFriend>((event, emit) async {
      emit(const _LoadingFriends());
      try {
        await _removeFriendUseCase(friendId: event.friendId);
        emit(const _FriendRemoved());
      } catch (e) {
        emit(_Error(message: e.toString()));
      }
    });
  }
}
