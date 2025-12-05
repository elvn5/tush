import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:get_it/get_it.dart';
import 'package:tush/features/auth/presentation/bloc/auth_bloc.dart';

@injectable
class AuthInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final session = await Amplify.Auth.fetchAuthSession();
      safePrint('Auth Session isSignedIn: ${session.isSignedIn}');

      if (!session.isSignedIn) {
        safePrint('User is not signed in, redirecting to login');
        GetIt.I<AuthBloc>().add(const AuthEvent.logoutRequested());
        return handler.reject(
          DioException(
            requestOptions: options,
            error: 'User is not signed in',
            type: DioExceptionType.cancel,
          ),
        );
      }

      if (session is CognitoAuthSession) {
        final tokensResult = session.userPoolTokensResult;
        final tokens = tokensResult.valueOrNull;
        if (tokens != null) {
          final idToken = tokens.idToken.raw;
          safePrint('Attaching Auth Token: ${idToken.substring(0, 10)}...');
          options.headers['Authorization'] = 'Bearer $idToken';
          return super.onRequest(options, handler);
        } else {
          safePrint(
            'No tokens available in session: ${tokensResult.exception}',
          );
          GetIt.I<AuthBloc>().add(const AuthEvent.logoutRequested());
          return handler.reject(
            DioException(
              requestOptions: options,
              error: 'No authentication tokens available',
              type: DioExceptionType.cancel,
            ),
          );
        }
      } else {
        safePrint('Session is not CognitoAuthSession');
        GetIt.I<AuthBloc>().add(const AuthEvent.logoutRequested());
        return handler.reject(
          DioException(
            requestOptions: options,
            error: 'Invalid session type',
            type: DioExceptionType.cancel,
          ),
        );
      }
    } catch (e) {
      safePrint('Error fetching auth session: $e');
      GetIt.I<AuthBloc>().add(const AuthEvent.logoutRequested());
      return handler.reject(
        DioException(
          requestOptions: options,
          error: 'Failed to fetch auth session: $e',
          type: DioExceptionType.cancel,
        ),
      );
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      GetIt.I<AuthBloc>().add(const AuthEvent.logoutRequested());
    }
    super.onError(err, handler);
  }
}
