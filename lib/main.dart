import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'routes/app_router.dart';
import 'amplifyconfiguration.dart';
import 'injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  await _configureAmplify();
  runApp(MyApp());
}

Future<void> _configureAmplify() async {
  try {
    final auth = AmplifyAuthCognito();
    final api = AmplifyAPI();
    await Amplify.addPlugin(auth);
    await Amplify.addPlugin(api);

    // call Amplify.configure to use the initialized categories in your app
    await Amplify.configure(amplifyconfig);
  } on Exception catch (e) {
    safePrint('An error occurred configuring Amplify: $e');
  }
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: FlexThemeData.light(
        scheme: FlexScheme.indigo,
        fontFamily: GoogleFonts.raleway().fontFamily,
      ),
      darkTheme: FlexThemeData.dark(
        scheme: FlexScheme.indigo,
        fontFamily: GoogleFonts.raleway().fontFamily,
      ),
      themeMode: ThemeMode.system,
      routerConfig: _appRouter.config(),
    );
  }
}
