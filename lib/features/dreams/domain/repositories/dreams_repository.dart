import '../entities/dream.dart';

abstract class DreamsRepository {
  Future<void> saveDream(String text);
  Future<List<Dream>> getDreams();
}
