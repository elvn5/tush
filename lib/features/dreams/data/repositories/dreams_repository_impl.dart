import 'dart:convert';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:tush/features/dreams/data/models/dream_dto.dart';
import 'package:tush/features/dreams/domain/entities/dream.dart';
import '../../domain/repositories/dreams_repository.dart';

import 'package:tush/core/config/app_config.dart';

@LazySingleton(as: DreamsRepository)
class DreamsRepositoryImpl implements DreamsRepository {
  final Dio _dio;

  DreamsRepositoryImpl(this._dio);

  @override
  @override
  Future<void> saveDream(String text) async {
    try {
      final String apiUrl = '${AppConfig.apiUrl}/dreams';

      final title = text.length > 20 ? '${text.substring(0, 20)}...' : text;

      await _dio.post(apiUrl, data: {'title': title, 'dream': text});
    } catch (e) {
      safePrint('Error saving dream: $e');
      rethrow;
    }
  }

  @override
  Future<List<Dream>> getDreams() async {
    try {
      final String apiUrl = '${AppConfig.apiUrl}/dreams';
      final response = await _dio.get(apiUrl);

      if (response.statusCode == 200) {
        final dynamic responseData = response.data;
        final List<dynamic> data;
        if (responseData is String) {
          data = jsonDecode(responseData) as List<dynamic>;
        } else {
          data = responseData as List<dynamic>;
        }
        return data.map((json) => DreamDTO.fromJson(json).toDomain()).toList();
      } else {
        throw Exception('Failed to load dreams');
      }
    } catch (e) {
      safePrint('Error fetching dreams: $e');
      rethrow;
    }
  }
}
