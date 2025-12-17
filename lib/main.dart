import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:firebase_core/firebase_core.dart';
import 'routes/app_router.dart';
import 'injection.dart';
import 'package:tush/core/presentation/theme/app_theme.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tush/core/presentation/bloc/theme_cubit.dart';

import 'dart:async';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tush/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:upgrader/upgrader.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(
      (await getApplicationDocumentsDirectory()).path,
    ),
  );

  // Initialize Firebase before anything else
  await Firebase.initializeApp();

  configureDependencies();
  await _configureAmplify();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ru')],
      path: 'assets/translations',
      fallbackLocale: const Locale('ru'),
      startLocale: const Locale('ru'),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => GetIt.I<ThemeCubit>()),
          BlocProvider(
            create: (context) =>
                GetIt.I<AuthBloc>()..add(const AuthEvent.checkRequested()),
          ),
        ],
        child: Tush(),
      ),
    ),
  );
}

Future<void> _configureAmplify() async {
  try {
    final auth = AmplifyAuthCognito();
    await Amplify.addPlugin(auth);

    // Load amplify_outputs.json from assets (Amplify Gen2 format)
    final configJson = await rootBundle.loadString(
      'assets/amplify_outputs.json',
    );
    await Amplify.configure(configJson);
  } on Exception catch (e) {
    safePrint('An error occurred configuring Amplify: $e');
  }
}

class Tush extends StatelessWidget {
  Tush({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, themeMode) {
            return UpgradeAlert(
              child: MaterialApp.router(
                title: "Morpheus",
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                theme: AppTheme.light,
                darkTheme: AppTheme.dark,
                themeMode: themeMode,
                routerConfig: _appRouter.config(
                  reevaluateListenable: StreamListenable(
                    GetIt.I<AuthBloc>().stream,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class StreamListenable extends ChangeNotifier {
  late final StreamSubscription _subscription;

  StreamListenable(Stream stream) {
    _subscription = stream.listen((_) => notifyListeners());
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
