import 'package:injectable/injectable.dart';
import '../../domain/entities/friend_user.dart';
import '../../domain/repositories/friends_repository.dart';

@lazySingleton
class GetFriendsUseCase {
  final FriendsRepository _repository;

  GetFriendsUseCase(this._repository);

  Future<List<FriendUser>> call() {
    return _repository.getFriends();
  }
}
