import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../domain/usecases/sign_up_use_case.dart';

part 'sign_up_bloc.freezed.dart';

@freezed
abstract class SignUpEvent with _$SignUpEvent {
  const factory SignUpEvent.submit({
    required String email,
    required String password,
  }) = _Submit;
}

@freezed
abstract class SignUpState with _$SignUpState {
  const factory SignUpState.initial() = _Initial;
  const factory SignUpState.loading() = _Loading;
  const factory SignUpState.success() = _Success;
  const factory SignUpState.failure(String message) = _Failure;
}

@injectable
class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpUseCase _signUpUseCase;

  SignUpBloc(this._signUpUseCase) : super(const _Initial()) {
    on<_Submit>((event, emit) async {
      emit(const _Loading());
      try {
        await _signUpUseCase(email: event.email, password: event.password);
        emit(const _Success());
      } catch (e) {
        emit(_Failure(e.toString()));
      }
    });
  }
}
