import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get_it/get_it.dart';
import '../bloc/sign_up_bloc.dart';
import 'package:tush/routes/app_router.gr.dart';
import 'package:gap/gap.dart';

import 'package:tush/core/presentation/widgets/widgets.dart';

@RoutePage()
class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Force rebuild when locale changes
    context.locale;
    return BlocProvider(
      create: (context) => GetIt.I<SignUpBloc>(),
      child: Scaffold(
        appBar: AppBar(title: AppTitleMedium(text: 'sign_up'.tr())),
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
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isPasswordVisible = useState(false);

    return BlocConsumer<SignUpBloc, SignUpState>(
      listener: (context, state) {
        state.maybeWhen(
          success: () {
            final email =
                formKey.currentState?.fields['email']?.value as String?;
            if (email != null) {
              context.router.push(ConfirmationRoute(email: email));
            }
          },
          failure: (message) {
            final errorMessage = message.contains('User already exists')
                ? 'user_already_exists'.tr()
                : message;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: AppBodyMedium(text: errorMessage, color: Colors.white),
              ),
            );
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
                  AppTitleLarge(text: 'create_account'.tr()),
                  const Gap(8),
                  AppBodyLarge(text: 'sign_up_started'.tr()),
                  const Gap(32),
                  AppFormBuilderTextField(
                    name: 'firstName',
                    label: 'first_name'.tr(),
                    hint: 'enter_first_name'.tr(),
                    prefixIcon: const Icon(Icons.person_outline),
                  ),
                  const Gap(16),
                  AppFormBuilderTextField(
                    name: 'lastName',
                    label: 'last_name'.tr(),
                    hint: 'enter_last_name'.tr(),
                    prefixIcon: const Icon(Icons.person_outline),
                  ),
                  const Gap(16),
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
                    obscureText: !isPasswordVisible.value,
                    suffixIcon: IconButton(
                      icon: Icon(
                        isPasswordVisible.value
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                      onPressed: () {
                        isPasswordVisible.value = !isPasswordVisible.value;
                      },
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                        errorText: 'please_enter_password'.tr(),
                      ),
                      FormBuilderValidators.minLength(
                        8,
                        errorText: 'password_min_length'.tr(),
                      ),
                      FormBuilderValidators.match(
                        r'(?=.*[0-9])',
                        errorText: 'password_must_contain_number'.tr(),
                      ),
                      FormBuilderValidators.match(
                        r'(?=.*[a-z])',
                        errorText: 'password_must_contain_lowercase'.tr(),
                      ),
                    ]),
                  ),
                  const Gap(24),
                  AppButton(
                    text: 'sign_up'.tr(),
                    isLoading: state.maybeWhen(
                      loading: () => true,
                      orElse: () => false,
                    ),
                    onPressed: () {
                      if (formKey.currentState?.saveAndValidate() ?? false) {
                        final values = formKey.currentState?.value;
                        if (values != null) {
                          context.read<SignUpBloc>().add(
                            SignUpEvent.submit(
                              email: values['email'],
                              password: values['password'],
                              firstName: values['firstName'],
                              lastName: values['lastName'],
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
                        context.router.push(const SignInRoute());
                      },
                      child: AppBodyMedium(
                        text: 'already_have_account'.tr(),
                        color: Theme.of(context).primaryColor,
                      ),
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
