import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:tush/routes/app_router.gr.dart';
import 'package:gap/gap.dart';
import '../bloc/sign_in_bloc.dart';

import 'package:tush/core/presentation/widgets/widgets.dart';

@RoutePage()
class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I<SignInBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('sign_in'.tr()),
          actions: const [SettingsSpeedDial()],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _SignInForm(),
        ),
      ),
    );
  }
}

class _SignInForm extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final formKey = useMemoized(() => GlobalKey<FormState>());

    return BlocConsumer<SignInBloc, SignInState>(
      listener: (context, state) {
        state.maybeWhen(
          success: () {
            context.router.replace(const HomeRoute());
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
                  CustomTitleLarge(text: 'welcome_back'.tr()),
                  const Gap(8),
                  CustomBodyLarge(text: 'sign_in_continue'.tr()),
                  const Gap(32),
                  CustomTextField(
                    controller: emailController,
                    label: 'email'.tr(),
                    hint: 'enter_email'.tr(),
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: const Icon(Icons.email_outlined),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please_enter_email'.tr();
                      }
                      return null;
                    },
                  ),
                  const Gap(16),
                  CustomTextField(
                    controller: passwordController,
                    label: 'password'.tr(),
                    hint: 'enter_password'.tr(),
                    obscureText: true,
                    prefixIcon: const Icon(Icons.lock_outline),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please_enter_password'.tr();
                      }
                      return null;
                    },
                  ),
                  const Gap(24),
                  CustomButton(
                    text: 'sign_in'.tr(),
                    isLoading: state.maybeWhen(
                      loading: () => true,
                      orElse: () => false,
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<SignInBloc>().add(
                          SignInEvent.submit(
                            email: emailController.text,
                            password: passwordController.text,
                          ),
                        );
                      }
                    },
                  ),
                  const Gap(16),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        context.router.push(const SignUpRoute());
                      },
                      child: Text('no_account'.tr()),
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
