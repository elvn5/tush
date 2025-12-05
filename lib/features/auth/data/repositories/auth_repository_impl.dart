import 'package:injectable/injectable.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import '../../domain/entities/user.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl(this._remoteDataSource);

  @override
  Future<void> signUp({required String email, required String password}) async {
    return _remoteDataSource.signUp(email: email, password: password);
  }

  @override
  Future<void> signIn({required String email, required String password}) async {
    return _remoteDataSource.signIn(email: email, password: password);
  }

  @override
  Future<User?> getCurrentUser() async {
    return _remoteDataSource.getCurrentUser();
  }

  @override
  Future<void> signOut() async {
    return _remoteDataSource.signOut();
  }

  @override
  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    return _remoteDataSource.changePassword(
      oldPassword: oldPassword,
      newPassword: newPassword,
    );
  }

  @override
  Future<void> confirmSignUp({
    required String email,
    required String confirmationCode,
  }) async {
    return _remoteDataSource.confirmSignUp(
      email: email,
      confirmationCode: confirmationCode,
    );
  }

  @override
  Future<void> resetPassword({required String email}) async {
    return _remoteDataSource.resetPassword(email: email);
  }

  @override
  Future<void> confirmResetPassword({
    required String email,
    required String newPassword,
    required String confirmationCode,
  }) async {
    return _remoteDataSource.confirmResetPassword(
      email: email,
      newPassword: newPassword,
      confirmationCode: confirmationCode,
    );
  }

  @override
  Future<void> deleteAccount() async {
    return _remoteDataSource.deleteAccount();
  }
}
