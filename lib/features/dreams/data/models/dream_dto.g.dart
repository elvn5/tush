// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dream_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DreamDTO _$DreamDTOFromJson(Map<String, dynamic> json) => _DreamDTO(
  dreamId: json['dreamId'] as String,
  title: json['title'] as String,
  text: json['dream'] as String,
  createdAt: (json['createdAt'] as num?)?.toInt(),
  isReady: json['isReady'] as bool? ?? false,
);

Map<String, dynamic> _$DreamDTOToJson(_DreamDTO instance) => <String, dynamic>{
  'dreamId': instance.dreamId,
  'title': instance.title,
  'dream': instance.text,
  'createdAt': instance.createdAt,
  'isReady': instance.isReady,
};
