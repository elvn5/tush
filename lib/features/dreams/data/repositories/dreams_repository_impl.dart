import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repositories/dreams_repository.dart';

import 'package:tush/core/config/app_config.dart';

@LazySingleton(as: DreamsRepository)
class DreamsRepositoryImpl implements DreamsRepository {
  final Dio _dio;

  DreamsRepositoryImpl(this._dio);

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
}
