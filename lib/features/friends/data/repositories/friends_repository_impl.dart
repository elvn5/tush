import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:tush/core/config/app_config.dart';
import 'package:tush/features/friends/domain/entities/friend_user.dart';
import 'package:tush/features/friends/domain/repositories/friends_repository.dart';

@LazySingleton(as: FriendsRepository)
class FriendsRepositoryImpl implements FriendsRepository {
  final Dio _dio;

  FriendsRepositoryImpl(this._dio);

  @override
  Future<List<FriendUser>> searchUsers({required String query}) async {
    try {
      final String apiUrl = '${AppConfig.apiUrl}/users/search';

      final response = await _dio.get(
        apiUrl,
        queryParameters: {'query': query},
      );

      if (response.statusCode == 200) {
        final dynamic responseData = response.data;
        final Map<String, dynamic> data;
        if (responseData is String) {
          data = jsonDecode(responseData) as Map<String, dynamic>;
        } else {
          data = responseData as Map<String, dynamic>;
        }

        final users = (data['users'] as List<dynamic>)
            .map(
              (json) => FriendUser(
                id: json['id'] as String,
                email: json['email'] as String,
                name: json['name'] as String?,
              ),
            )
            .toList();

        return users;
      } else {
        throw Exception('Failed to search users');
      }
    } catch (e) {
      debugPrint('Error searching users: $e');
      rethrow;
    }
  }

  @override
  Future<void> addFriend({required String friendId}) async {
    try {
      final String apiUrl = '${AppConfig.apiUrl}/friends';
      debugPrint('Adding friend with ID: $friendId');
      final response = await _dio.post(apiUrl, data: {'friendId': friendId});
      debugPrint('Add friend response status: ${response.statusCode}');
      debugPrint('Add friend response data: ${response.data}');
    } catch (e) {
      debugPrint('Error adding friend: $e');
      rethrow;
    }
  }

  @override
  Future<List<FriendUser>> getFriends() async {
    try {
      final String apiUrl = '${AppConfig.apiUrl}/friends';
      final response = await _dio.get(apiUrl);

      if (response.statusCode == 200) {
        final dynamic responseData = response.data;
        final Map<String, dynamic> data;
        if (responseData is String) {
          data = jsonDecode(responseData) as Map<String, dynamic>;
        } else {
          data = responseData as Map<String, dynamic>;
        }

        final friends = (data['friends'] as List<dynamic>)
            .map(
              (json) => FriendUser(
                id: json['id'] as String,
                email: json['email'] as String,
                name: json['name'] as String?,
              ),
            )
            .toList();

        return friends;
      } else {
        throw Exception('Failed to get friends');
      }
    } catch (e) {
      debugPrint('Error getting friends: $e');
      rethrow;
    }
  }

  @override
  Future<void> removeFriend({required String friendId}) async {
    try {
      final String apiUrl = '${AppConfig.apiUrl}/friends/$friendId';
      await _dio.delete(apiUrl);
    } catch (e) {
      debugPrint('Error removing friend: $e');
      rethrow;
    }
  }
}
