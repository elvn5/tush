import 'package:freezed_annotation/freezed_annotation.dart';
import 'dream.dart';

part 'paginated_dreams.freezed.dart';

@freezed
abstract class PaginatedDreams with _$PaginatedDreams {
  const factory PaginatedDreams({
    required List<Dream> items,
    String? nextCursor,
  }) = _PaginatedDreams;
}
