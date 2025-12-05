import '../entities/user.dart';

abstract class AuthRepository {
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
  Future<void> resetPassword({required String email});
  Future<void> confirmResetPassword({
    required String email,
    required String newPassword,
    required String confirmationCode,
  });
  Future<void> deleteAccount();
}
