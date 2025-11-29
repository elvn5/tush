import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:tush/features/auth/presentation/bloc/auth_bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tush/core/presentation/widgets/widgets.dart';
import 'package:tush/features/dreams/presentation/bloc/dreams_bloc.dart';

@RoutePage()
class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());

    return BlocProvider(
      create: (context) => GetIt.I<DreamsBloc>(),
      child: BlocListener<DreamsBloc, DreamsState>(
        listener: (context, state) {
          state.maybeWhen(
            success: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Dream saved successfully!')),
              );
              formKey.currentState?.reset();
            },
            failure: (message) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(message)));
            },
            orElse: () {},
          );
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('home'.tr(context: context)),
            actions: [
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () {
                  GetIt.I<AuthBloc>().add(const AuthEvent.logoutRequested());
                },
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FormBuilder(
              key: formKey,
              child: Column(
                children: [
                  AppFormBuilderTextField(
                    name: 'dream',
                    label: 'Your Dream',
                    hint: 'Describe your dream...',
                    maxLines: 5,
                  ),
                  const SizedBox(height: 16),
                  BlocBuilder<DreamsBloc, DreamsState>(
                    builder: (context, state) {
                      return AppButton(
                        text: 'Save Dream',
                        isLoading: state.maybeWhen(
                          loading: () => true,
                          orElse: () => false,
                        ),
                        onPressed: () {
                          if (formKey.currentState?.saveAndValidate() ??
                              false) {
                            final dreamText =
                                formKey.currentState?.value['dream'] as String?;
                            if (dreamText != null && dreamText.isNotEmpty) {
                              context.read<DreamsBloc>().add(
                                DreamsEvent.add(dreamText),
                              );
                            }
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
