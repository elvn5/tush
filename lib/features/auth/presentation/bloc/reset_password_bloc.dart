import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../domain/usecases/confirm_reset_password_use_case.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';
part 'reset_password_bloc.freezed.dart';

@injectable
class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  final ConfirmResetPasswordUseCase _confirmResetPasswordUseCase;

  ResetPasswordBloc(this._confirmResetPasswordUseCase)
    : super(const ResetPasswordState.initial()) {
    on<_Submit>((event, emit) async {
      emit(const ResetPasswordState.loading());
      try {
        await _confirmResetPasswordUseCase(
          email: event.email,
          newPassword: event.newPassword,
          confirmationCode: event.code,
        );
        emit(const ResetPasswordState.success());
      } catch (e) {
        emit(ResetPasswordState.failure(e.toString()));
      }
    });
  }
}
