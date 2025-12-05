import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get_it/get_it.dart';
import 'package:gap/gap.dart';
import 'package:tush/core/presentation/widgets/widgets.dart';
import 'package:tush/routes/app_router.gr.dart';
import '../bloc/forgot_password_bloc.dart';

@RoutePage()
class ForgotPasswordScreen extends HookWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());

    return BlocProvider(
      create: (context) => GetIt.I<ForgotPasswordBloc>(),
      child: BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
        listener: (context, state) {
          state.maybeWhen(
            success: () {
              final email =
                  formKey.currentState?.fields['email']?.value as String?;
              if (email != null) {
                context.router.push(ResetPasswordRoute(email: email));
              }
            },
            failure: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: AppBodyMedium(text: message, color: Colors.white),
                ),
              );
            },
            orElse: () {},
          );
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title: AppTitleMedium(text: 'forgot_password'.tr())),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: SingleChildScrollView(
                  child: FormBuilder(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTitleLarge(text: 'reset_password'.tr()),
                        const Gap(8),
                        AppBodyLarge(
                          text: 'enter_email_reset_instruction'.tr(),
                        ),
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
                        const Gap(24),
                        AppButton(
                          text: 'send_code'.tr(),
                          isLoading: state.maybeWhen(
                            loading: () => true,
                            orElse: () => false,
                          ),
                          onPressed: () {
                            if (formKey.currentState?.saveAndValidate() ??
                                false) {
                              final values = formKey.currentState?.value;
                              if (values != null) {
                                context.read<ForgotPasswordBloc>().add(
                                  ForgotPasswordEvent.submit(
                                    email: values['email'],
                                  ),
                                );
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
