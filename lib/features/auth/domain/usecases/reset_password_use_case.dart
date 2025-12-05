import 'package:injectable/injectable.dart';
import '../repositories/auth_repository.dart';

@lazySingleton
class ResetPasswordUseCase {
  final AuthRepository _authRepository;

  ResetPasswordUseCase(this._authRepository);

  Future<void> call({required String email}) {
    return _authRepository.resetPassword(email: email);
  }
}
