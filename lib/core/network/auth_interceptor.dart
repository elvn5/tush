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
      if (session is CognitoAuthSession) {
        final idToken = session.userPoolTokensResult.value.idToken.raw;
        safePrint('Attaching Auth Token: ${idToken.substring(0, 10)}...');
        options.headers['Authorization'] = 'Bearer $idToken';
      } else {
        safePrint('Session is not CognitoAuthSession');
      }
    } catch (e) {
      safePrint('Error fetching auth session: $e');
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      GetIt.I<AuthBloc>().add(const AuthEvent.logoutRequested());
    }
    super.onError(err, handler);
  }
}
