import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:tush/core/config/app_config.dart';
import 'package:tush/features/friends/domain/entities/friend_user.dart';

abstract class FriendRequestsRepository {
  Future<List<FriendUser>> getFriendRequests();
  Future<void> acceptFriendRequest({required String senderId});
  Future<void> declineFriendRequest({required String senderId});
}

@LazySingleton(as: FriendRequestsRepository)
class FriendRequestsRepositoryImpl implements FriendRequestsRepository {
  final Dio _dio;

  FriendRequestsRepositoryImpl(this._dio);

  @override
  Future<List<FriendUser>> getFriendRequests() async {
    try {
      final response = await _dio.get('${AppConfig.apiUrl}/friend-requests');

      debugPrint('Friend requests response status: ${response.statusCode}');
      debugPrint('Friend requests response data: ${response.data}');

      if (response.statusCode == 200) {
        final dynamic responseData = response.data;
        final Map<String, dynamic> data;
        if (responseData is String) {
          data = jsonDecode(responseData) as Map<String, dynamic>;
        } else {
          data = responseData as Map<String, dynamic>;
        }

        debugPrint('Parsed friend requests data: $data');

        final requests = (data['requests'] as List<dynamic>)
            .map(
              (json) => FriendUser(
                id: json['id'] as String,
                email: json['email'] as String,
                name: json['name'] as String?,
              ),
            )
            .toList();

        debugPrint('Parsed ${requests.length} friend requests');
        return requests;
      } else {
        throw Exception('Failed to load friend requests');
      }
    } catch (e) {
      debugPrint('Error getting friend requests: $e');
      rethrow;
    }
  }

  @override
  Future<void> acceptFriendRequest({required String senderId}) async {
    await _dio.post('${AppConfig.apiUrl}/friend-requests/$senderId/accept');
  }

  @override
  Future<void> declineFriendRequest({required String senderId}) async {
    await _dio.post('${AppConfig.apiUrl}/friend-requests/$senderId/decline');
  }
}
