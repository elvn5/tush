import '../entities/friend_user.dart';

abstract class FriendsRepository {
  Future<List<FriendUser>> searchUsers({required String query});
  Future<void> addFriend({required String friendId});
  Future<List<FriendUser>> getFriends();
  Future<void> removeFriend({required String friendId});
}
