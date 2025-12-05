import 'package:injectable/injectable.dart';
import '../repositories/auth_repository.dart';

@lazySingleton
class ConfirmResetPasswordUseCase {
  final AuthRepository _authRepository;

  ConfirmResetPasswordUseCase(this._authRepository);

  Future<void> call({
    required String email,
    required String newPassword,
    required String confirmationCode,
  }) {
    return _authRepository.confirmResetPassword(
      email: email,
      newPassword: newPassword,
      confirmationCode: confirmationCode,
    );
  }
}
