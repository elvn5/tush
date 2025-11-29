// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dream.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Dream _$DreamFromJson(Map<String, dynamic> json) => _Dream(
  id: json['id'] as String,
  text: json['text'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$DreamToJson(_Dream instance) => <String, dynamic>{
  'id': instance.id,
  'text': instance.text,
  'createdAt': instance.createdAt.toIso8601String(),
};
