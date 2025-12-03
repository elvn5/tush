import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../domain/usecases/sign_up_use_case.dart';
import '../../domain/usecases/confirm_sign_up_use_case.dart';

part 'sign_up_bloc.freezed.dart';

@freezed
abstract class SignUpEvent with _$SignUpEvent {
  const factory SignUpEvent.submit({
    required String email,
    required String password,
  }) = _Submit;
  const factory SignUpEvent.confirm({
    required String email,
    required String code,
  }) = _Confirm;
}

@freezed
abstract class SignUpState with _$SignUpState {
  const factory SignUpState.initial() = _Initial;
  const factory SignUpState.loading() = _Loading;
  const factory SignUpState.success() = _Success;
  const factory SignUpState.confirmSuccess() = _ConfirmSuccess;
  const factory SignUpState.failure(String message) = _Failure;
}

@injectable
class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpUseCase _signUpUseCase;
  final ConfirmSignUpUseCase _confirmSignUpUseCase;

  SignUpBloc(this._signUpUseCase, this._confirmSignUpUseCase)
    : super(const _Initial()) {
    on<_Submit>((event, emit) async {
      emit(const _Loading());
      try {
        await _signUpUseCase(email: event.email, password: event.password);
        // Assuming auto-login after sign up, or user needs to sign in?
        // Usually SignUp just creates account. If it auto-logs in, we dispatch LoginSuccess.
        // If it requires verification or separate login, we don't.
        // The previous implementation didn't seem to auto-login explicitly in Bloc,
        // but Amplify might sign in after sign up if configured?
        // Standard Cognito: Sign Up -> Confirm -> Sign In.
        // If so, we shouldn't dispatch LoginSuccess here unless we are sure.
        // But the user request implies "After user signs [in?], the session...".
        // I'll assume Sign Up leads to Sign In screen or auto-login.
        // If I look at SignUpScreen, it navigates to SignInRoute on success?
        // Let's check SignUpScreen navigation.
        // For now, I will NOT dispatch LoginSuccess in SignUpBloc to be safe,
        // unless I see code that does auto-login.
        // I will just add the dependency if needed, or skip this file if not needed.
        // Wait, I selected to update SignUpBloc in the plan.
        // Let's check if I really need to update it.
        // If SignUp just succeeds and we go to SignIn, then SignInBloc handles the login.
        // So I might skip updating SignUpBloc logic, but I need to make sure I don't break anything.
        // Actually, I'll check SignUpScreen first.
        emit(const _Success());
      } catch (e) {
        emit(_Failure(e.toString()));
      }
    });
    on<_Confirm>((event, emit) async {
      emit(const _Loading());
      try {
        await _confirmSignUpUseCase(
          email: event.email,
          confirmationCode: event.code,
        );
        emit(const _ConfirmSuccess());
      } catch (e) {
        emit(_Failure(e.toString()));
      }
    });
  }
}
