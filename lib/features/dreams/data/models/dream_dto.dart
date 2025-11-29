import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/dream.dart';

part 'dream_dto.freezed.dart';
part 'dream_dto.g.dart';

@freezed
abstract class DreamDTO with _$DreamDTO {
  const DreamDTO._();

  const factory DreamDTO({
    required String dreamId,
    required String title,
    @JsonKey(name: 'dream') required String text,
    String? interpretation,
    int? createdAt,
    @Default(false) bool isReady,
  }) = _DreamDTO;

  factory DreamDTO.fromJson(Map<String, dynamic> json) =>
      _$DreamDTOFromJson(json);

  Dream toDomain() {
    return Dream(
      id: dreamId,
      title: title,
      text: text,
      interpretation: interpretation,
      isReady: isReady,
      createdAt: createdAt != null
          ? DateTime.fromMillisecondsSinceEpoch(createdAt!)
          : null,
    );
  }
}
