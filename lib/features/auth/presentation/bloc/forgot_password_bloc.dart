import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../domain/usecases/reset_password_use_case.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';
part 'forgot_password_bloc.freezed.dart';

@injectable
class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final ResetPasswordUseCase _resetPasswordUseCase;

  ForgotPasswordBloc(this._resetPasswordUseCase)
    : super(const ForgotPasswordState.initial()) {
    on<_Submit>((event, emit) async {
      emit(const ForgotPasswordState.loading());
      try {
        await _resetPasswordUseCase(email: event.email);
        emit(const ForgotPasswordState.success());
      } catch (e) {
        emit(ForgotPasswordState.failure(e.toString()));
      }
    });
  }
}
