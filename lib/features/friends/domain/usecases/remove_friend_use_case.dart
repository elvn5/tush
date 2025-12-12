import 'package:injectable/injectable.dart';
import '../repositories/friends_repository.dart';

@lazySingleton
class RemoveFriendUseCase {
  final FriendsRepository _repository;

  RemoveFriendUseCase(this._repository);

  Future<void> call({required String friendId}) {
    return _repository.removeFriend(friendId: friendId);
  }
}
