import '../entities/paginated_dreams.dart';

abstract class DreamsRepository {
  Future<void> saveDream(String text);
  Future<PaginatedDreams> getDreams({
    int limit = 10,
    String? cursor,
    String? search,
    bool? status,
    DateTime? startDate,
    DateTime? endDate,
  });
  Future<PaginatedDreams> getFriendDreams({
    required String friendId,
    int limit = 10,
    String? cursor,
  });
  Future<void> deleteDream(String id);
}
