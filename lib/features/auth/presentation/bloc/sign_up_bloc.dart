import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../domain/usecases/sign_up_use_case.dart';
import '../../domain/usecases/confirm_sign_up_use_case.dart';
import '../../../../core/services/analytics_service.dart';

part 'sign_up_bloc.freezed.dart';

@freezed
abstract class SignUpEvent with _$SignUpEvent {
  const factory SignUpEvent.submit({
    required String email,
    required String password,
    String? firstName,
    String? lastName,
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
  final AnalyticsService _analyticsService;

  SignUpBloc(
    this._signUpUseCase,
    this._confirmSignUpUseCase,
    this._analyticsService,
  ) : super(const _Initial()) {
    on<_Submit>((event, emit) async {
      emit(const _Loading());
      try {
        await _signUpUseCase(
          email: event.email,
          password: event.password,
          firstName: event.firstName,
          lastName: event.lastName,
        );

        // Track analytics
        await _analyticsService.trackSignUp(method: 'email');

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
