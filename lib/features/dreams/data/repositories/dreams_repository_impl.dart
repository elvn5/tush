import 'dart:convert';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:tush/features/dreams/data/models/dream_dto.dart';
import '../../domain/entities/paginated_dreams.dart';
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
  Future<PaginatedDreams> getDreams({
    int limit = 10,
    String? cursor,
    String? search,
    bool? status,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final String apiUrl = '${AppConfig.apiUrl}/dreams';
      final queryParameters = {
        'limit': limit,
        if (cursor != null) 'cursor': cursor,
        if (search != null && search.isNotEmpty) 'search': search,
        if (status != null) 'status': status,
        if (startDate != null) 'startDate': startDate.millisecondsSinceEpoch,
        if (endDate != null) 'endDate': endDate.millisecondsSinceEpoch,
      };

      final response = await _dio.get(apiUrl, queryParameters: queryParameters);

      if (response.statusCode == 200) {
        final dynamic responseData = response.data;
        final Map<String, dynamic> data;
        if (responseData is String) {
          data = jsonDecode(responseData) as Map<String, dynamic>;
        } else {
          data = responseData as Map<String, dynamic>;
        }

        final items = (data['items'] as List<dynamic>)
            .map((json) => DreamDTO.fromJson(json).toDomain())
            .toList();
        final nextCursor = data['nextCursor'] as String?;

        return PaginatedDreams(items: items, nextCursor: nextCursor);
      } else {
        throw Exception('Failed to load dreams');
      }
    } catch (e) {
      safePrint('Error fetching dreams: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteDream(String id) async {
    try {
      final String apiUrl = '${AppConfig.apiUrl}/dreams/$id';
      await _dio.delete(apiUrl);
    } catch (e) {
      safePrint('Error deleting dream: $e');
      rethrow;
    }
  }
}
