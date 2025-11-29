import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../domain/usecases/sign_in_use_case.dart';
import '../../domain/exceptions/auth_exceptions.dart';
import 'auth_bloc.dart';

part 'sign_in_bloc.freezed.dart';

@freezed
abstract class SignInEvent with _$SignInEvent {
  const factory SignInEvent.submit({
    required String email,
    required String password,
  }) = _Submit;
}

@freezed
abstract class SignInState with _$SignInState {
  const factory SignInState.initial() = _Initial;
  const factory SignInState.loading() = _Loading;
  const factory SignInState.success() = _Success;
  const factory SignInState.userNotConfirmed() = _UserNotConfirmed;
  const factory SignInState.failure(String message) = _Failure;
}

@injectable
class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final SignInUseCase _signInUseCase;
  final AuthBloc _authBloc;

  SignInBloc(this._signInUseCase, this._authBloc) : super(const _Initial()) {
    on<_Submit>((event, emit) async {
      emit(const _Loading());
      try {
        await _signInUseCase(email: event.email, password: event.password);
        _authBloc.add(const AuthEvent.loginSuccess());
        emit(const _Success());
      } on UserNotConfirmedDomainException catch (_) {
        emit(const _UserNotConfirmed());
      } catch (e) {
        emit(_Failure(e.toString()));
      }
    });
  }
}
