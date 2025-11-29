import 'package:freezed_annotation/freezed_annotation.dart';

// Domain entity for a Dream

part 'dream.freezed.dart';
part 'dream.g.dart';

@freezed
abstract class Dream with _$Dream {
  const factory Dream({
    required String id,
    required String text,
    required DateTime createdAt,
  }) = _Dream;

  factory Dream.fromJson(Map<String, dynamic> json) => _$DreamFromJson(json);
}
