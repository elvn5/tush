import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';
import 'package:tush/core/presentation/widgets/widgets.dart';
import 'package:tush/features/auth/presentation/bloc/profile_bloc.dart';
import 'package:tush/routes/app_router.gr.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GetIt.I<ProfileBloc>()..add(const ProfileEvent.started()),
      child: Scaffold(
        appBar: AppBar(title: Text('profile'.tr())),
        body: BlocConsumer<ProfileBloc, ProfileState>(
          listener: (context, state) {
            state.maybeWhen(
              logoutSuccess: () {
                context.router.replaceAll([const SignInRoute()]);
              },
              passwordChangeSuccess: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('password_changed_successfully'.tr())),
                );
                Navigator.of(context).pop(); // Close dialog
              },
              deleteAccountSuccess: () {
                context.router.replaceAll([const SignInRoute()]);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('account_deleted_successfully'.tr())),
                );
              },
              error: (message) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(message)));
              },
              orElse: () {},
            );
          },
          builder: (context, state) {
            return state.maybeWhen(
              loading: () => const Center(child: CircularProgressIndicator()),
              loaded: (user) => SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      child: Icon(Icons.person, size: 50),
                    ),
                    const Gap(16),
                    Text(
                      user.name ?? 'no_name'.tr(),
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const Gap(8),
                    Text(
                      user.email,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    if (user.phoneNumber != null) ...[
                      const Gap(8),
                      Text(
                        user.phoneNumber!,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                    const Gap(32),
                    AppButton(
                      text: 'change_password'.tr(),
                      onPressed: () => _showChangePasswordDialog(context),
                    ),
                    const Gap(16),
                    AppButton(
                      text: 'logout'.tr(),
                      onPressed: () {
                        context.read<ProfileBloc>().add(
                          const ProfileEvent.logoutRequested(),
                        );
                      },
                      backgroundColor: Theme.of(context).colorScheme.error,
                      textColor: Theme.of(context).colorScheme.onError,
                    ),
                    const Gap(16),
                    AppButton(
                      text: 'delete_account'.tr(),
                      onPressed: () => _showDeleteAccountConfirmation(context),
                      backgroundColor: Theme.of(
                        context,
                      ).colorScheme.errorContainer,
                      textColor: Theme.of(context).colorScheme.onErrorContainer,
                    ),
                  ],
                ),
              ),
              orElse: () => const SizedBox.shrink(),
            );
          },
        ),
      ),
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    showDialog(
      context: context,
      builder: (dialogContext) {
        return BlocProvider.value(
          value: context.read<ProfileBloc>(),
          child: AlertDialog(
            title: Text('change_password'.tr()),
            content: FormBuilder(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppFormBuilderTextField(
                    name: 'old_password',
                    label: 'old_password'.tr(),
                    obscureText: true,
                    validator: FormBuilderValidators.required(),
                  ),
                  const Gap(16),
                  AppFormBuilderTextField(
                    name: 'new_password',
                    label: 'new_password'.tr(),
                    obscureText: true,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.minLength(8),
                    ]),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: Text('cancel'.tr()),
              ),
              TextButton(
                onPressed: () {
                  if (formKey.currentState?.saveAndValidate() ?? false) {
                    final values = formKey.currentState?.value;
                    if (values != null) {
                      context.read<ProfileBloc>().add(
                        ProfileEvent.passwordChangeRequested(
                          oldPassword: values['old_password'],
                          newPassword: values['new_password'],
                        ),
                      );
                    }
                  }
                },
                child: Text('change'.tr()),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDeleteAccountConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text('delete_account'.tr()),
          content: Text('delete_account_confirmation'.tr()),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text('cancel'.tr()),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                context.read<ProfileBloc>().add(
                  const ProfileEvent.deleteAccountRequested(),
                );
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: Text('delete'.tr()),
            ),
          ],
        );
      },
    );
  }
}
