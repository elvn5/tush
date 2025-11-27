import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:tush/core/presentation/widgets/custom_form_container.dart';
import '../bloc/sign_up_bloc.dart';
import 'package:tush/core/presentation/widgets/custom_button.dart';
import 'package:tush/core/presentation/widgets/custom_text_field.dart';
import 'package:tush/core/presentation/widgets/custom_typography.dart';
import 'package:gap/gap.dart';

@RoutePage()
class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I<SignUpBloc>(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Sign Up')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _SignUpForm(),
        ),
      ),
    );
  }
}

class _SignUpForm extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final formKey = useMemoized(() => GlobalKey<FormState>());

    return BlocConsumer<SignUpBloc, SignUpState>(
      listener: (context, state) {
        state.maybeWhen(
          success: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Sign up successful!')),
            );
            // Navigate to home or login
          },
          failure: (message) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(message)));
          },
          orElse: () {},
        );
      },
      builder: (context, state) {
        return Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomTitleLarge(text: 'Create Account'),
                  const Gap(8),
                  const CustomBodyLarge(text: 'Sign up to get started'),
                  const Gap(32),
                  AppContainer(
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: emailController,
                          label: 'Email',
                          hint: 'Enter your email',
                          keyboardType: TextInputType.emailAddress,
                          prefixIcon: const Icon(Icons.email_outlined),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),
                        const Gap(16),
                        CustomTextField(
                          controller: passwordController,
                          label: 'Password',
                          hint: 'Enter your password',
                          obscureText: true,
                          prefixIcon: const Icon(Icons.lock_outline),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                        const Gap(24),
                        CustomButton(
                          text: 'Sign Up',
                          isLoading: state.maybeWhen(
                            loading: () => true,
                            orElse: () => false,
                          ),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              context.read<SignUpBloc>().add(
                                SignUpEvent.submit(
                                  email: emailController.text,
                                  password: passwordController.text,
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
