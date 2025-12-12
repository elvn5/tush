import 'package:injectable/injectable.dart';
import '../entities/friend_user.dart';
import '../repositories/friends_repository.dart';

@lazySingleton
class SearchUsersUseCase {
  final FriendsRepository _repository;

  SearchUsersUseCase(this._repository);

  Future<List<FriendUser>> call({required String query}) {
    return _repository.searchUsers(query: query);
  }
}
