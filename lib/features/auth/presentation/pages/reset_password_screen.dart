import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get_it/get_it.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';
import 'package:tush/core/presentation/widgets/widgets.dart';
import 'package:tush/routes/app_router.gr.dart';
import '../bloc/reset_password_bloc.dart';

@RoutePage()
class ResetPasswordScreen extends HookWidget {
  final String email;

  const ResetPasswordScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final pinController = useTextEditingController();

    return BlocProvider(
      create: (context) => GetIt.I<ResetPasswordBloc>(),
      child: BlocConsumer<ResetPasswordBloc, ResetPasswordState>(
        listener: (context, state) {
          state.maybeWhen(
            success: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: AppBodyMedium(
                    text: 'password_reset_success'.tr(),
                    color: Colors.white,
                  ),
                ),
              );
              context.router.replaceAll([const SignInRoute()]);
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
            appBar: AppBar(title: AppTitleMedium(text: 'reset_password'.tr())),
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
                        AppTitleLarge(text: 'enter_new_password'.tr()),
                        const Gap(8),
                        AppBodyLarge(
                          text: 'enter_code_reset_instruction'.tr(
                            args: [email],
                          ),
                        ),
                        const Gap(32),
                        Center(
                          child: Pinput(controller: pinController, length: 6),
                        ),
                        const Gap(24),
                        AppFormBuilderTextField(
                          name: 'newPassword',
                          label: 'new_password'.tr(),
                          hint: 'enter_new_password'.tr(),
                          prefixIcon: const Icon(Icons.lock_outline),
                          obscureText: true,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                              errorText: 'please_enter_password'.tr(),
                            ),
                            FormBuilderValidators.minLength(
                              8,
                              errorText: 'password_min_length'.tr(),
                            ),
                          ]),
                        ),
                        const Gap(24),
                        AppButton(
                          text: 'reset_password'.tr(),
                          isLoading: state.maybeWhen(
                            loading: () => true,
                            orElse: () => false,
                          ),
                          onPressed: () {
                            if (formKey.currentState?.saveAndValidate() ??
                                false) {
                              final values = formKey.currentState?.value;
                              if (values != null &&
                                  pinController.text.length == 6) {
                                context.read<ResetPasswordBloc>().add(
                                  ResetPasswordEvent.submit(
                                    email: email,
                                    code: pinController.text,
                                    newPassword: values['newPassword'],
                                  ),
                                );
                              } else if (pinController.text.length != 6) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: AppBodyMedium(
                                      text: 'please_enter_code'.tr(),
                                      color: Colors.white,
                                    ),
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
