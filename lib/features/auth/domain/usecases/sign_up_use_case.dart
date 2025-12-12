import 'package:injectable/injectable.dart';
import '../repositories/auth_repository.dart';

@lazySingleton
class SignUpUseCase {
  final AuthRepository _repository;

  SignUpUseCase(this._repository);

  Future<void> call({
    required String email,
    required String password,
    String? firstName,
    String? lastName,
  }) {
    return _repository.signUp(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
    );
  }
}
