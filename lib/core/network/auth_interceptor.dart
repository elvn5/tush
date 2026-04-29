import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:get_it/get_it.dart';
import 'package:tush/core/services/token_storage.dart';
import 'package:tush/features/auth/presentation/bloc/auth_bloc.dart';

@injectable
class AuthInterceptor extends Interceptor {
  final TokenStorage _tokenStorage;

  AuthInterceptor(this._tokenStorage);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _tokenStorage.getToken();

    if (token == null) {
      GetIt.I<AuthBloc>().add(const AuthEvent.logoutRequested());
      return handler.reject(
        DioException(
          requestOptions: options,
          error: 'No authentication token',
          type: DioExceptionType.cancel,
        ),
      );
    }

    options.headers['Authorization'] = 'Bearer $token';
    return super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      _tokenStorage.deleteToken();
      GetIt.I<AuthBloc>().add(const AuthEvent.logoutRequested());
    }
    super.onError(err, handler);
  }
}
