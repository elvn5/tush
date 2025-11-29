import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get_it/get_it.dart';
import 'package:tush/routes/app_router.gr.dart';
import 'package:gap/gap.dart';
import '../bloc/sign_in_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:tush/core/presentation/widgets/widgets.dart';

@RoutePage()
class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I<SignInBloc>(),
      child: Scaffold(
        appBar: AppBar(title: Text('sign_in'.tr())),
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
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());

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
          userNotConfirmed: () {
            Fluttertoast.showToast(
              msg: 'account_not_confirmed'.tr(),
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
            final email =
                formKey.currentState?.fields['email']?.value as String?;
            if (email != null) {
              context.router.push(ConfirmationRoute(email: email));
            }
          },
          orElse: () {},
        );
      },
      builder: (context, state) {
        return Center(
          child: SingleChildScrollView(
            child: FormBuilder(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTitleLarge(text: 'welcome_back'.tr()),
                  const Gap(8),
                  AppBodyLarge(text: 'sign_in_continue'.tr()),
                  const Gap(32),
                  AppFormBuilderTextField(
                    name: 'email',
                    label: 'email'.tr(),
                    hint: 'enter_email'.tr(),
                    prefixIcon: const Icon(Icons.email_outlined),
                    keyboardType: TextInputType.emailAddress,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                        errorText: 'please_enter_email'.tr(),
                      ),
                      FormBuilderValidators.email(
                        errorText: 'please_enter_valid_email'.tr(),
                      ),
                    ]),
                  ),
                  const Gap(16),
                  AppFormBuilderTextField(
                    name: 'password',
                    label: 'password'.tr(),
                    hint: 'enter_password'.tr(),
                    prefixIcon: const Icon(Icons.lock_outline),
                    obscureText: true,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                        errorText: 'please_enter_password'.tr(),
                      ),
                    ]),
                  ),
                  const Gap(24),
                  AppButton(
                    text: 'sign_in'.tr(),
                    isLoading: state.maybeWhen(
                      loading: () => true,
                      orElse: () => false,
                    ),
                    onPressed: () {
                      if (formKey.currentState?.saveAndValidate() ?? false) {
                        final values = formKey.currentState?.value;
                        if (values != null) {
                          context.read<SignInBloc>().add(
                            SignInEvent.submit(
                              email: values['email'],
                              password: values['password'],
                            ),
                          );
                        }
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
