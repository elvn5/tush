import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

import 'package:injectable/injectable.dart';

import '../../domain/entities/user.dart';
import '../../domain/exceptions/auth_exceptions.dart';

abstract class AuthRemoteDataSource {
  Future<void> signUp({required String email, required String password});
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

      if (result.nextStep.signInStep == AuthSignInStep.confirmSignUp) {
        throw UserNotConfirmedDomainException('User is not confirmed.');
      }

      // Ensure the session is fetched and cached
      await Amplify.Auth.fetchAuthSession();
    } on UserNotConfirmedException catch (e) {
      safePrint('User not confirmed: ${e.message}');
      throw UserNotConfirmedDomainException(e.message);
    } on AuthException catch (e) {
      safePrint('Error signing in user: ${e.message}');
      rethrow;
    }
  }

  @override
  Future<User?> getCurrentUser() async {
    try {
      final session = await Amplify.Auth.fetchAuthSession();
      if (!session.isSignedIn) {
        return null;
      }
      final attributes = await Amplify.Auth.fetchUserAttributes();
      final userId = await Amplify.Auth.getCurrentUser();
      String email = '';
      String? name;
      String? phoneNumber;

      for (final attribute in attributes) {
        if (attribute.userAttributeKey == AuthUserAttributeKey.email) {
          email = attribute.value;
        } else if (attribute.userAttributeKey == AuthUserAttributeKey.name) {
          name = attribute.value;
        } else if (attribute.userAttributeKey ==
            AuthUserAttributeKey.phoneNumber) {
          phoneNumber = attribute.value;
        }
      }

      return User(
        id: userId.userId,
        email: email,
        name: name,
        phoneNumber: phoneNumber,
      );
    } catch (e) {
      safePrint('Error fetching user: $e');
      return null;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await Amplify.Auth.signOut();
    } on AuthException catch (e) {
      safePrint('Error signing out: ${e.message}');
      rethrow;
    }
  }

  @override
  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      await Amplify.Auth.updatePassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
      );
    } on AuthException catch (e) {
      safePrint('Error changing password: ${e.message}');
      rethrow;
    }
  }

  @override
  Future<void> confirmSignUp({
    required String email,
    required String confirmationCode,
  }) async {
    try {
      final result = await Amplify.Auth.confirmSignUp(
        username: email,
        confirmationCode: confirmationCode,
      );
      safePrint('Confirm sign up result: $result');
    } on AuthException catch (e) {
      safePrint('Error confirming sign up: ${e.message}');
      rethrow;
    }
  }
}
