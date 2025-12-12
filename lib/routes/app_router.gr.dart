// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i14;
import 'package:flutter/material.dart' as _i15;
import 'package:tush/core/presentation/pages/dashboard_screen.dart' as _i3;
import 'package:tush/core/presentation/pages/privacy_policy_screen.dart' as _i8;
import 'package:tush/core/presentation/pages/settings_screen.dart' as _i11;
import 'package:tush/features/auth/presentation/pages/auth_screen.dart' as _i1;
import 'package:tush/features/auth/presentation/pages/confirmation_screen.dart'
    as _i2;
import 'package:tush/features/auth/presentation/pages/forgot_password_screen.dart'
    as _i5;
import 'package:tush/features/auth/presentation/pages/profile_screen.dart'
    as _i9;
import 'package:tush/features/auth/presentation/pages/reset_password_screen.dart'
    as _i10;
import 'package:tush/features/auth/presentation/pages/sign_in_screen.dart'
    as _i12;
import 'package:tush/features/auth/presentation/pages/sign_up_screen.dart'
    as _i13;
import 'package:tush/features/dreams/domain/entities/dream.dart' as _i16;
import 'package:tush/features/dreams/presentation/pages/dream_detail_screen.dart'
    as _i4;
import 'package:tush/features/dreams/presentation/pages/home_screen.dart'
    as _i7;
import 'package:tush/features/friends/presentation/pages/friends_screen.dart'
    as _i6;

/// generated route for
/// [_i1.AuthScreen]
class AuthRoute extends _i14.PageRouteInfo<void> {
  const AuthRoute({List<_i14.PageRouteInfo>? children})
    : super(AuthRoute.name, initialChildren: children);

  static const String name = 'AuthRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i1.AuthScreen();
    },
  );
}

/// generated route for
/// [_i2.ConfirmationScreen]
class ConfirmationRoute extends _i14.PageRouteInfo<ConfirmationRouteArgs> {
  ConfirmationRoute({
    _i15.Key? key,
    required String email,
    List<_i14.PageRouteInfo>? children,
  }) : super(
         ConfirmationRoute.name,
         args: ConfirmationRouteArgs(key: key, email: email),
         initialChildren: children,
       );

  static const String name = 'ConfirmationRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ConfirmationRouteArgs>();
      return _i2.ConfirmationScreen(key: args.key, email: args.email);
    },
  );
}

class ConfirmationRouteArgs {
  const ConfirmationRouteArgs({this.key, required this.email});

  final _i15.Key? key;

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
class DashboardRoute extends _i14.PageRouteInfo<void> {
  const DashboardRoute({List<_i14.PageRouteInfo>? children})
    : super(DashboardRoute.name, initialChildren: children);

  static const String name = 'DashboardRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i3.DashboardScreen();
    },
  );
}

/// generated route for
/// [_i4.DreamDetailScreen]
class DreamDetailRoute extends _i14.PageRouteInfo<DreamDetailRouteArgs> {
  DreamDetailRoute({
    _i15.Key? key,
    required _i16.Dream dream,
    List<_i14.PageRouteInfo>? children,
  }) : super(
         DreamDetailRoute.name,
         args: DreamDetailRouteArgs(key: key, dream: dream),
         initialChildren: children,
       );

  static const String name = 'DreamDetailRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<DreamDetailRouteArgs>();
      return _i4.DreamDetailScreen(key: args.key, dream: args.dream);
    },
  );
}

class DreamDetailRouteArgs {
  const DreamDetailRouteArgs({this.key, required this.dream});

  final _i15.Key? key;

  final _i16.Dream dream;

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
/// [_i5.ForgotPasswordScreen]
class ForgotPasswordRoute extends _i14.PageRouteInfo<void> {
  const ForgotPasswordRoute({List<_i14.PageRouteInfo>? children})
    : super(ForgotPasswordRoute.name, initialChildren: children);

  static const String name = 'ForgotPasswordRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i5.ForgotPasswordScreen();
    },
  );
}

/// generated route for
/// [_i6.FriendsScreen]
class FriendsRoute extends _i14.PageRouteInfo<void> {
  const FriendsRoute({List<_i14.PageRouteInfo>? children})
    : super(FriendsRoute.name, initialChildren: children);

  static const String name = 'FriendsRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i6.FriendsScreen();
    },
  );
}

/// generated route for
/// [_i7.HomeScreen]
class HomeRoute extends _i14.PageRouteInfo<void> {
  const HomeRoute({List<_i14.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i7.HomeScreen();
    },
  );
}

/// generated route for
/// [_i8.PrivacyPolicyScreen]
class PrivacyPolicyRoute extends _i14.PageRouteInfo<void> {
  const PrivacyPolicyRoute({List<_i14.PageRouteInfo>? children})
    : super(PrivacyPolicyRoute.name, initialChildren: children);

  static const String name = 'PrivacyPolicyRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i8.PrivacyPolicyScreen();
    },
  );
}

/// generated route for
/// [_i9.ProfileScreen]
class ProfileRoute extends _i14.PageRouteInfo<void> {
  const ProfileRoute({List<_i14.PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i9.ProfileScreen();
    },
  );
}

/// generated route for
/// [_i10.ResetPasswordScreen]
class ResetPasswordRoute extends _i14.PageRouteInfo<ResetPasswordRouteArgs> {
  ResetPasswordRoute({
    _i15.Key? key,
    required String email,
    List<_i14.PageRouteInfo>? children,
  }) : super(
         ResetPasswordRoute.name,
         args: ResetPasswordRouteArgs(key: key, email: email),
         initialChildren: children,
       );

  static const String name = 'ResetPasswordRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ResetPasswordRouteArgs>();
      return _i10.ResetPasswordScreen(key: args.key, email: args.email);
    },
  );
}

class ResetPasswordRouteArgs {
  const ResetPasswordRouteArgs({this.key, required this.email});

  final _i15.Key? key;

  final String email;

  @override
  String toString() {
    return 'ResetPasswordRouteArgs{key: $key, email: $email}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ResetPasswordRouteArgs) return false;
    return key == other.key && email == other.email;
  }

  @override
  int get hashCode => key.hashCode ^ email.hashCode;
}

/// generated route for
/// [_i11.SettingsScreen]
class SettingsRoute extends _i14.PageRouteInfo<void> {
  const SettingsRoute({List<_i14.PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i11.SettingsScreen();
    },
  );
}

/// generated route for
/// [_i12.SignInScreen]
class SignInRoute extends _i14.PageRouteInfo<void> {
  const SignInRoute({List<_i14.PageRouteInfo>? children})
    : super(SignInRoute.name, initialChildren: children);

  static const String name = 'SignInRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i12.SignInScreen();
    },
  );
}

/// generated route for
/// [_i13.SignUpScreen]
class SignUpRoute extends _i14.PageRouteInfo<void> {
  const SignUpRoute({List<_i14.PageRouteInfo>? children})
    : super(SignUpRoute.name, initialChildren: children);

  static const String name = 'SignUpRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i13.SignUpScreen();
    },
  );
}
