import 'package:injectable/injectable.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

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
}
