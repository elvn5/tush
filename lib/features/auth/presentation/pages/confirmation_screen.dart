import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pinput/pinput.dart';
import 'package:tush/core/presentation/widgets/widgets.dart';
import 'package:tush/features/auth/presentation/bloc/sign_up_bloc.dart';
import 'package:tush/routes/app_router.gr.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

@RoutePage()
class ConfirmationScreen extends HookWidget {
  final String email;

  const ConfirmationScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final pinController = useTextEditingController();

    return BlocProvider(
      create: (context) => GetIt.I<SignUpBloc>(),
      child: BlocConsumer<SignUpBloc, SignUpState>(
        listener: (context, state) {
          state.maybeWhen(
            confirmSuccess: () {
              context.router.replaceAll([const SignInRoute()]);
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
          return Scaffold(
            appBar: AppBar(
              title: AppTitleMedium(text: 'confirm_sign_up_title'.tr()),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppTitleMedium(
                    text: 'enter_code_instruction'.tr(args: [email]),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  Pinput(
                    controller: pinController,
                    length: 6,
                    onCompleted: (pin) {
                      context.read<SignUpBloc>().add(
                        SignUpEvent.confirm(email: email, code: pin),
                      );
                    },
                  ),
                  const SizedBox(height: 32),
                  if (state.maybeWhen(loading: () => true, orElse: () => false))
                    const CircularProgressIndicator()
                  else
                    AppButton(
                      text: 'confirm'.tr(),
                      onPressed: () {
                        if (pinController.text.length == 6) {
                          context.read<SignUpBloc>().add(
                            SignUpEvent.confirm(
                              email: email,
                              code: pinController.text,
                            ),
                          );
                        }
                      },
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
