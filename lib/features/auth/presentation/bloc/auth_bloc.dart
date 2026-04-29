import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tush/core/services/analytics_service.dart';
import 'package:tush/core/services/token_storage.dart';

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
  final AnalyticsService _analyticsService;
  final TokenStorage _tokenStorage;

  AuthBloc(this._analyticsService, this._tokenStorage) : super(const _Initial()) {
    on<_CheckRequested>(_onCheckRequested);
    on<_LoginSuccess>(_onLoginSuccess);
    on<_LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onCheckRequested(
    _CheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    final token = await _tokenStorage.getToken();
    if (token != null && !_isTokenExpired(token)) {
      emit(const _Authenticated());
    } else {
      await _tokenStorage.deleteToken();
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
    await _tokenStorage.deleteToken();
    await _analyticsService.trackLogout();
    emit(const _Unauthenticated());
  }

  bool _isTokenExpired(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return true;

      final payload = parts[1];
      final normalized = base64.normalize(payload);
      final decoded = utf8.decode(base64.decode(normalized));
      final map = json.decode(decoded) as Map<String, dynamic>;

      final exp = map['exp'] as int?;
      if (exp == null) return true;

      return DateTime.fromMillisecondsSinceEpoch(exp * 1000)
          .isBefore(DateTime.now());
    } catch (_) {
      return true;
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
