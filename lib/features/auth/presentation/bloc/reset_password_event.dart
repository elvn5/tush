part of 'reset_password_bloc.dart';

@freezed
abstract class ResetPasswordEvent with _$ResetPasswordEvent {
  const factory ResetPasswordEvent.submit({
    required String email,
    required String code,
    required String newPassword,
  }) = _Submit;
}
