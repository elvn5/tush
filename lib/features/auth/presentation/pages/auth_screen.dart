import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../../routes/app_router.gr.dart';

@RoutePage()
class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.router.replace(const HomeRoute());
          },
          child: const Text('Login'),
        ),
      ),
    );
  }
}
