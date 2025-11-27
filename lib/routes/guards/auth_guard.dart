import 'package:auto_route/auto_route.dart';
import 'package:get_it/get_it.dart';
import 'package:tush/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:tush/routes/app_router.gr.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final authBloc = GetIt.I<AuthBloc>();
    authBloc.state.maybeMap(
      authenticated: (_) => resolver.next(true),
      orElse: () => resolver.redirectUntil(const SignInRoute()),
    );
  }
}
