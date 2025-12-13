// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i15;
import 'package:flutter/material.dart' as _i16;
import 'package:tush/core/presentation/pages/dashboard_screen.dart' as _i3;
import 'package:tush/core/presentation/pages/privacy_policy_screen.dart' as _i9;
import 'package:tush/core/presentation/pages/settings_screen.dart' as _i12;
import 'package:tush/features/auth/presentation/pages/auth_screen.dart' as _i1;
import 'package:tush/features/auth/presentation/pages/confirmation_screen.dart'
    as _i2;
import 'package:tush/features/auth/presentation/pages/forgot_password_screen.dart'
    as _i5;
import 'package:tush/features/auth/presentation/pages/profile_screen.dart'
    as _i10;
import 'package:tush/features/auth/presentation/pages/reset_password_screen.dart'
    as _i11;
import 'package:tush/features/auth/presentation/pages/sign_in_screen.dart'
    as _i13;
import 'package:tush/features/auth/presentation/pages/sign_up_screen.dart'
    as _i14;
import 'package:tush/features/dreams/domain/entities/dream.dart' as _i17;
import 'package:tush/features/dreams/presentation/pages/dream_detail_screen.dart'
    as _i4;
import 'package:tush/features/dreams/presentation/pages/home_screen.dart'
    as _i8;
import 'package:tush/features/friends/presentation/pages/friend_dreams_screen.dart'
    as _i6;
import 'package:tush/features/friends/presentation/pages/friends_screen.dart'
    as _i7;

/// generated route for
/// [_i1.AuthScreen]
class AuthRoute extends _i15.PageRouteInfo<void> {
  const AuthRoute({List<_i15.PageRouteInfo>? children})
    : super(AuthRoute.name, initialChildren: children);

  static const String name = 'AuthRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i1.AuthScreen();
    },
  );
}

/// generated route for
/// [_i2.ConfirmationScreen]
class ConfirmationRoute extends _i15.PageRouteInfo<ConfirmationRouteArgs> {
  ConfirmationRoute({
    _i16.Key? key,
    required String email,
    List<_i15.PageRouteInfo>? children,
  }) : super(
         ConfirmationRoute.name,
         args: ConfirmationRouteArgs(key: key, email: email),
         initialChildren: children,
       );

  static const String name = 'ConfirmationRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ConfirmationRouteArgs>();
      return _i2.ConfirmationScreen(key: args.key, email: args.email);
    },
  );
}

class ConfirmationRouteArgs {
  const ConfirmationRouteArgs({this.key, required this.email});

  final _i16.Key? key;

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
class DashboardRoute extends _i15.PageRouteInfo<void> {
  const DashboardRoute({List<_i15.PageRouteInfo>? children})
    : super(DashboardRoute.name, initialChildren: children);

  static const String name = 'DashboardRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i3.DashboardScreen();
    },
  );
}

/// generated route for
/// [_i4.DreamDetailScreen]
class DreamDetailRoute extends _i15.PageRouteInfo<DreamDetailRouteArgs> {
  DreamDetailRoute({
    _i16.Key? key,
    required _i17.Dream dream,
    List<_i15.PageRouteInfo>? children,
  }) : super(
         DreamDetailRoute.name,
         args: DreamDetailRouteArgs(key: key, dream: dream),
         initialChildren: children,
       );

  static const String name = 'DreamDetailRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<DreamDetailRouteArgs>();
      return _i4.DreamDetailScreen(key: args.key, dream: args.dream);
    },
  );
}

class DreamDetailRouteArgs {
  const DreamDetailRouteArgs({this.key, required this.dream});

  final _i16.Key? key;

  final _i17.Dream dream;

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
class ForgotPasswordRoute extends _i15.PageRouteInfo<void> {
  const ForgotPasswordRoute({List<_i15.PageRouteInfo>? children})
    : super(ForgotPasswordRoute.name, initialChildren: children);

  static const String name = 'ForgotPasswordRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i5.ForgotPasswordScreen();
    },
  );
}

/// generated route for
/// [_i6.FriendDreamsScreen]
class FriendDreamsRoute extends _i15.PageRouteInfo<FriendDreamsRouteArgs> {
  FriendDreamsRoute({
    _i16.Key? key,
    required String friendId,
    required String friendName,
    required String friendEmail,
    List<_i15.PageRouteInfo>? children,
  }) : super(
         FriendDreamsRoute.name,
         args: FriendDreamsRouteArgs(
           key: key,
           friendId: friendId,
           friendName: friendName,
           friendEmail: friendEmail,
         ),
         initialChildren: children,
       );

  static const String name = 'FriendDreamsRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<FriendDreamsRouteArgs>();
      return _i6.FriendDreamsScreen(
        key: args.key,
        friendId: args.friendId,
        friendName: args.friendName,
        friendEmail: args.friendEmail,
      );
    },
  );
}

class FriendDreamsRouteArgs {
  const FriendDreamsRouteArgs({
    this.key,
    required this.friendId,
    required this.friendName,
    required this.friendEmail,
  });

  final _i16.Key? key;

  final String friendId;

  final String friendName;

  final String friendEmail;

  @override
  String toString() {
    return 'FriendDreamsRouteArgs{key: $key, friendId: $friendId, friendName: $friendName, friendEmail: $friendEmail}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! FriendDreamsRouteArgs) return false;
    return key == other.key &&
        friendId == other.friendId &&
        friendName == other.friendName &&
        friendEmail == other.friendEmail;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      friendId.hashCode ^
      friendName.hashCode ^
      friendEmail.hashCode;
}

/// generated route for
/// [_i7.FriendsScreen]
class FriendsRoute extends _i15.PageRouteInfo<void> {
  const FriendsRoute({List<_i15.PageRouteInfo>? children})
    : super(FriendsRoute.name, initialChildren: children);

  static const String name = 'FriendsRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i7.FriendsScreen();
    },
  );
}

/// generated route for
/// [_i8.HomeScreen]
class HomeRoute extends _i15.PageRouteInfo<void> {
  const HomeRoute({List<_i15.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i8.HomeScreen();
    },
  );
}

/// generated route for
/// [_i9.PrivacyPolicyScreen]
class PrivacyPolicyRoute extends _i15.PageRouteInfo<void> {
  const PrivacyPolicyRoute({List<_i15.PageRouteInfo>? children})
    : super(PrivacyPolicyRoute.name, initialChildren: children);

  static const String name = 'PrivacyPolicyRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i9.PrivacyPolicyScreen();
    },
  );
}

/// generated route for
/// [_i10.ProfileScreen]
class ProfileRoute extends _i15.PageRouteInfo<void> {
  const ProfileRoute({List<_i15.PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i10.ProfileScreen();
    },
  );
}

/// generated route for
/// [_i11.ResetPasswordScreen]
class ResetPasswordRoute extends _i15.PageRouteInfo<ResetPasswordRouteArgs> {
  ResetPasswordRoute({
    _i16.Key? key,
    required String email,
    List<_i15.PageRouteInfo>? children,
  }) : super(
         ResetPasswordRoute.name,
         args: ResetPasswordRouteArgs(key: key, email: email),
         initialChildren: children,
       );

  static const String name = 'ResetPasswordRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ResetPasswordRouteArgs>();
      return _i11.ResetPasswordScreen(key: args.key, email: args.email);
    },
  );
}

class ResetPasswordRouteArgs {
  const ResetPasswordRouteArgs({this.key, required this.email});

  final _i16.Key? key;

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
/// [_i12.SettingsScreen]
class SettingsRoute extends _i15.PageRouteInfo<void> {
  const SettingsRoute({List<_i15.PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i12.SettingsScreen();
    },
  );
}

/// generated route for
/// [_i13.SignInScreen]
class SignInRoute extends _i15.PageRouteInfo<void> {
  const SignInRoute({List<_i15.PageRouteInfo>? children})
    : super(SignInRoute.name, initialChildren: children);

  static const String name = 'SignInRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i13.SignInScreen();
    },
  );
}

/// generated route for
/// [_i14.SignUpScreen]
class SignUpRoute extends _i15.PageRouteInfo<void> {
  const SignUpRoute({List<_i15.PageRouteInfo>? children})
    : super(SignUpRoute.name, initialChildren: children);

  static const String name = 'SignUpRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i14.SignUpScreen();
    },
  );
}
