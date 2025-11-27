import 'package:amplify_flutter/amplify_flutter.dart' hide Emitter;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

part 'auth_bloc.freezed.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.checkRequested() = _CheckRequested;
  const factory AuthEvent.loginSuccess() = _LoginSuccess;
  const factory AuthEvent.logoutRequested() = _LogoutRequested;
}

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.authenticated() = _Authenticated;
  const factory AuthState.unauthenticated() = _Unauthenticated;
}

@lazySingleton
class AuthBloc extends HydratedBloc<AuthEvent, AuthState> {
  AuthBloc() : super(const _Initial()) {
    on<_CheckRequested>(_onCheckRequested);
    on<_LoginSuccess>(_onLoginSuccess);
    on<_LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onCheckRequested(
    _CheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final session = await Amplify.Auth.fetchAuthSession();
      if (session.isSignedIn) {
        emit(const _Authenticated());
      } else {
        emit(const _Unauthenticated());
      }
    } catch (_) {
      emit(const _Unauthenticated());
    }
  }

  void _onLoginSuccess(_LoginSuccess event, Emitter<AuthState> emit) {
    emit(const _Authenticated());
  }

  Future<void> _onLogoutRequested(
    _LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await Amplify.Auth.signOut();
      emit(const _Unauthenticated());
    } catch (_) {
      emit(const _Unauthenticated());
    }
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String?;
    switch (type) {
      case 'authenticated':
        return const AuthState.authenticated();
      case 'unauthenticated':
        return const AuthState.unauthenticated();
      default:
        return const AuthState.initial();
    }
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    return state.when(
      initial: () => {'type': 'initial'},
      authenticated: () => {'type': 'authenticated'},
      unauthenticated: () => {'type': 'unauthenticated'},
    );
  }
}
