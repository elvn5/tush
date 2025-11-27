import 'package:injectable/injectable.dart';
import '../repositories/auth_repository.dart';

@lazySingleton
class SignInUseCase {
  final AuthRepository _repository;

  SignInUseCase(this._repository);

  Future<void> call({required String email, required String password}) {
    return _repository.signIn(email: email, password: password);
  }
}
