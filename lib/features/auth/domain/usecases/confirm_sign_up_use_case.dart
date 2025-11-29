import 'package:injectable/injectable.dart';
import '../repositories/auth_repository.dart';

@injectable
class ConfirmSignUpUseCase {
  final AuthRepository _repository;

  ConfirmSignUpUseCase(this._repository);

  Future<void> call({
    required String email,
    required String confirmationCode,
  }) async {
    return _repository.confirmSignUp(
      email: email,
      confirmationCode: confirmationCode,
    );
  }
}
