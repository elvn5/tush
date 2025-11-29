import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';

part 'profile_bloc.freezed.dart';

@freezed
class ProfileEvent with _$ProfileEvent {
  const factory ProfileEvent.started() = _Started;
  const factory ProfileEvent.logoutRequested() = _LogoutRequested;
  const factory ProfileEvent.passwordChangeRequested({
    required String oldPassword,
    required String newPassword,
  }) = _PasswordChangeRequested;
}

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState.initial() = _Initial;
  const factory ProfileState.loading() = _Loading;
  const factory ProfileState.loaded(User user) = _Loaded;
  const factory ProfileState.error(String message) = _Error;
  const factory ProfileState.logoutSuccess() = _LogoutSuccess;
  const factory ProfileState.passwordChangeSuccess() = _PasswordChangeSuccess;
}

@injectable
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AuthRepository _authRepository;

  ProfileBloc(this._authRepository) : super(const _Initial()) {
    on<_Started>(_onStarted);
    on<_LogoutRequested>(_onLogoutRequested);
    on<_PasswordChangeRequested>(_onPasswordChangeRequested);
  }

  Future<void> _onStarted(_Started event, Emitter<ProfileState> emit) async {
    emit(const _Loading());
    try {
      final user = await _authRepository.getCurrentUser();
      if (user != null) {
        emit(_Loaded(user));
      } else {
        emit(const _Error('User not found'));
      }
    } catch (e) {
      emit(_Error(e.toString()));
    }
  }

  Future<void> _onLogoutRequested(
    _LogoutRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const _Loading());
    try {
      await _authRepository.signOut();
      emit(const _LogoutSuccess());
    } catch (e) {
      emit(_Error(e.toString()));
    }
  }

  Future<void> _onPasswordChangeRequested(
    _PasswordChangeRequested event,
    Emitter<ProfileState> emit,
  ) async {
    // We keep the current state if it's loaded to show loading overlay or similar
    // But for simplicity, let's just emit loading
    final currentUser = state.maybeWhen(
      loaded: (user) => user,
      orElse: () => null,
    );

    emit(const _Loading());
    try {
      await _authRepository.changePassword(
        oldPassword: event.oldPassword,
        newPassword: event.newPassword,
      );
      emit(const _PasswordChangeSuccess());
      if (currentUser != null) {
        emit(_Loaded(currentUser));
      }
    } catch (e) {
      emit(_Error(e.toString()));
      if (currentUser != null) {
        emit(_Loaded(currentUser));
      }
    }
  }
}
