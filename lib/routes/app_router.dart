import 'package:auto_route/auto_route.dart';

import 'app_router.gr.dart';

import 'guards/auth_guard.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SignInRoute.page),
    AutoRoute(page: SignUpRoute.page),
    AutoRoute(page: ConfirmationRoute.page),
    AutoRoute(page: ForgotPasswordRoute.page),
    AutoRoute(page: ResetPasswordRoute.page),
    AutoRoute(
      page: DashboardRoute.page,
      initial: true,
      guards: [AuthGuard()],
      children: [
        AutoRoute(page: HomeRoute.page),
        AutoRoute(page: ProfileRoute.page),
        AutoRoute(page: SettingsRoute.page),
      ],
    ),
    AutoRoute(page: DreamDetailRoute.page),
    AutoRoute(page: PrivacyPolicyRoute.page, path: '/privacy-policy'),
  ];
}
