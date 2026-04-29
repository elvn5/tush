import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:tush/core/config/app_config.dart';
import 'package:tush/core/services/token_storage.dart';
import '../../domain/entities/user.dart';
import '../../domain/exceptions/auth_exceptions.dart';

abstract class AuthRemoteDataSource {
  Future<void> signUp({
    required String email,
    required String password,
    String? firstName,
    String? lastName,
  });
  Future<void> signIn({required String email, required String password});
  Future<User?> getCurrentUser();
  Future<void> signOut();
  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  });
  Future<void> confirmSignUp({
    required String email,
    required String confirmationCode,
  });
  Future<void> resetPassword({required String email});
  Future<void> confirmResetPassword({
    required String email,
    required String newPassword,
    required String confirmationCode,
  });
  Future<void> deleteAccount();
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio _dio;
  final TokenStorage _tokenStorage;

  AuthRemoteDataSourceImpl(this._dio, this._tokenStorage);

  @override
  Future<void> signUp({
    required String email,
    required String password,
    String? firstName,
    String? lastName,
  }) async {
    String? name;
    if (firstName != null && firstName.isNotEmpty) {
      name = [firstName, if (lastName != null && lastName.isNotEmpty) lastName]
          .join(' ');
    }

    try {
      await _dio.post(
        '${AppConfig.apiUrl}/auth/register',
        data: {'email': email, 'password': password, 'name': name},
        options: Options(headers: {}),
      );
    } on DioException catch (e) {
      throw _mapDioError(e);
    }
  }

  @override
  Future<void> signIn({required String email, required String password}) async {
    try {
      final response = await _dio.post(
        '${AppConfig.apiUrl}/auth/login',
        data: {'email': email, 'password': password},
        options: Options(headers: {}),
      );

      final token = response.data['token'] as String;
      await _tokenStorage.saveToken(token);
    } on DioException catch (e) {
      if (e.response?.statusCode == 403) {
        final error = e.response?.data['error'] as String? ?? '';
        if (error == 'user_not_confirmed') {
          throw UserNotConfirmedDomainException('User is not confirmed.');
        }
      }
      throw _mapDioError(e);
    }
  }

  @override
  Future<User?> getCurrentUser() async {
    final token = await _tokenStorage.getToken();
    if (token == null) return null;

    try {
      final response = await _dio.get('${AppConfig.apiUrl}/auth/me');
      final data = response.data as Map<String, dynamic>;
      return User(
        id: data['id'] as String,
        email: data['email'] as String,
        name: data['name'] as String?,
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        await _tokenStorage.deleteToken();
        return null;
      }
      return null;
    }
  }

  @override
  Future<void> signOut() async {
    await _tokenStorage.deleteToken();
  }

  @override
  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      await _dio.put(
        '${AppConfig.apiUrl}/auth/password',
        data: {'old_password': oldPassword, 'new_password': newPassword},
      );
    } on DioException catch (e) {
      throw _mapDioError(e);
    }
  }

  @override
  Future<void> confirmSignUp({
    required String email,
    required String confirmationCode,
  }) async {
    try {
      await _dio.post(
        '${AppConfig.apiUrl}/auth/confirm',
        data: {'email': email, 'code': confirmationCode},
        options: Options(headers: {}),
      );
    } on DioException catch (e) {
      throw _mapDioError(e);
    }
  }

  @override
  Future<void> resetPassword({required String email}) async {
    try {
      await _dio.post(
        '${AppConfig.apiUrl}/auth/forgot-password',
        data: {'email': email},
        options: Options(headers: {}),
      );
    } on DioException catch (e) {
      throw _mapDioError(e);
    }
  }

  @override
  Future<void> confirmResetPassword({
    required String email,
    required String newPassword,
    required String confirmationCode,
  }) async {
    try {
      await _dio.post(
        '${AppConfig.apiUrl}/auth/reset-password',
        data: {
          'email': email,
          'code': confirmationCode,
          'new_password': newPassword,
        },
        options: Options(headers: {}),
      );
    } on DioException catch (e) {
      throw _mapDioError(e);
    }
  }

  @override
  Future<void> deleteAccount() async {
    try {
      await _dio.delete('${AppConfig.apiUrl}/auth/me');
      await _tokenStorage.deleteToken();
    } on DioException catch (e) {
      throw _mapDioError(e);
    }
  }

  Exception _mapDioError(DioException e) {
    final message = e.response?.data?['error'] as String?;
    return Exception(message ?? e.message ?? 'Unknown error');
  }
}
