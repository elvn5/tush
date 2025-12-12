import 'package:injectable/injectable.dart';
import '../repositories/friends_repository.dart';

@lazySingleton
class AddFriendUseCase {
  final FriendsRepository _repository;

  AddFriendUseCase(this._repository);

  Future<void> call({required String friendId}) {
    return _repository.addFriend(friendId: friendId);
  }
}
