import 'package:amplify_flutter/amplify_flutter.dart';

import 'package:injectable/injectable.dart';

abstract class AuthRemoteDataSource {
  Future<void> signUp({required String email, required String password});
  Future<void> signIn({required String email, required String password});
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<void> signUp({required String email, required String password}) async {
    try {
      final result = await Amplify.Auth.signUp(
        username: email,
        password: password,
        options: SignUpOptions(
          userAttributes: {AuthUserAttributeKey.email: email},
        ),
      );
      safePrint('Sign up result: $result');
    } on AuthException catch (e) {
      safePrint('Error signing up user: ${e.message}');
      rethrow;
    }
  }

  @override
  Future<void> signIn({required String email, required String password}) async {
    try {
      final result = await Amplify.Auth.signIn(
        username: email,
        password: password,
      );
      safePrint('Sign in result: $result');
    } on AuthException catch (e) {
      safePrint('Error signing in user: ${e.message}');
      rethrow;
    }
  }
}
