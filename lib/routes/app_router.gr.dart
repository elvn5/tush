// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i10;
import 'package:flutter/material.dart' as _i11;
import 'package:tush/features/auth/presentation/pages/confirmation_screen.dart'
    as _i2;
import 'package:tush/features/auth/presentation/pages/sign_in_screen.dart'
    as _i8;
import 'package:tush/features/auth/presentation/pages/sign_up_screen.dart'
    as _i9;
import 'package:tush/features/dreams/domain/entities/dream.dart' as _i12;
import 'package:tush/screens/auth_screen.dart' as _i1;
import 'package:tush/screens/dashboard_screen.dart' as _i3;
import 'package:tush/screens/dream_detail_screen.dart' as _i4;
import 'package:tush/screens/home_screen.dart' as _i5;
import 'package:tush/screens/profile_screen.dart' as _i6;
import 'package:tush/screens/settings_screen.dart' as _i7;

/// generated route for
/// [_i1.AuthScreen]
class AuthRoute extends _i10.PageRouteInfo<void> {
  const AuthRoute({List<_i10.PageRouteInfo>? children})
    : super(AuthRoute.name, initialChildren: children);

  static const String name = 'AuthRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i1.AuthScreen();
    },
  );
}

/// generated route for
/// [_i2.ConfirmationScreen]
class ConfirmationRoute extends _i10.PageRouteInfo<ConfirmationRouteArgs> {
  ConfirmationRoute({
    _i11.Key? key,
    required String email,
    List<_i10.PageRouteInfo>? children,
  }) : super(
         ConfirmationRoute.name,
         args: ConfirmationRouteArgs(key: key, email: email),
         initialChildren: children,
       );

  static const String name = 'ConfirmationRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ConfirmationRouteArgs>();
      return _i2.ConfirmationScreen(key: args.key, email: args.email);
    },
  );
}

class ConfirmationRouteArgs {
  const ConfirmationRouteArgs({this.key, required this.email});

  final _i11.Key? key;

  final String email;

  @override
  String toString() {
    return 'ConfirmationRouteArgs{key: $key, email: $email}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ConfirmationRouteArgs) return false;
    return key == other.key && email == other.email;
  }

  @override
  int get hashCode => key.hashCode ^ email.hashCode;
}

/// generated route for
/// [_i3.DashboardScreen]
class DashboardRoute extends _i10.PageRouteInfo<void> {
  const DashboardRoute({List<_i10.PageRouteInfo>? children})
    : super(DashboardRoute.name, initialChildren: children);

  static const String name = 'DashboardRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i3.DashboardScreen();
    },
  );
}

/// generated route for
/// [_i4.DreamDetailScreen]
class DreamDetailRoute extends _i10.PageRouteInfo<DreamDetailRouteArgs> {
  DreamDetailRoute({
    _i11.Key? key,
    required _i12.Dream dream,
    List<_i10.PageRouteInfo>? children,
  }) : super(
         DreamDetailRoute.name,
         args: DreamDetailRouteArgs(key: key, dream: dream),
         initialChildren: children,
       );

  static const String name = 'DreamDetailRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<DreamDetailRouteArgs>();
      return _i4.DreamDetailScreen(key: args.key, dream: args.dream);
    },
  );
}

class DreamDetailRouteArgs {
  const DreamDetailRouteArgs({this.key, required this.dream});

  final _i11.Key? key;

  final _i12.Dream dream;

  @override
  String toString() {
    return 'DreamDetailRouteArgs{key: $key, dream: $dream}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! DreamDetailRouteArgs) return false;
    return key == other.key && dream == other.dream;
  }

  @override
  int get hashCode => key.hashCode ^ dream.hashCode;
}

/// generated route for
/// [_i5.HomeScreen]
class HomeRoute extends _i10.PageRouteInfo<void> {
  const HomeRoute({List<_i10.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i5.HomeScreen();
    },
  );
}

/// generated route for
/// [_i6.ProfileScreen]
class ProfileRoute extends _i10.PageRouteInfo<void> {
  const ProfileRoute({List<_i10.PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i6.ProfileScreen();
    },
  );
}

/// generated route for
/// [_i7.SettingsScreen]
class SettingsRoute extends _i10.PageRouteInfo<void> {
  const SettingsRoute({List<_i10.PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i7.SettingsScreen();
    },
  );
}

/// generated route for
/// [_i8.SignInScreen]
class SignInRoute extends _i10.PageRouteInfo<void> {
  const SignInRoute({List<_i10.PageRouteInfo>? children})
    : super(SignInRoute.name, initialChildren: children);

  static const String name = 'SignInRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i8.SignInScreen();
    },
  );
}

/// generated route for
/// [_i9.SignUpScreen]
class SignUpRoute extends _i10.PageRouteInfo<void> {
  const SignUpRoute({List<_i10.PageRouteInfo>? children})
    : super(SignUpRoute.name, initialChildren: children);

  static const String name = 'SignUpRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i9.SignUpScreen();
    },
  );
}
