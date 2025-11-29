import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tush/core/presentation/widgets/widgets.dart';
import 'package:tush/features/dreams/presentation/bloc/dreams_bloc.dart';

class AddDreamModal extends HookWidget {
  const AddDreamModal({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: BlocListener<DreamsBloc, DreamsState>(
        listener: (context, state) {
          state.maybeWhen(
            success: () => Navigator.of(context).pop(),
            orElse: () {},
          );
        },
        child: FormBuilder(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'new_dream'.tr(), // You might need to add this key
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              AppFormBuilderTextField(
                name: 'dream',
                label: 'your_dream'.tr(),
                hint: 'describe_your_dream'.tr(),
                maxLines: 5,
              ),
              const SizedBox(height: 16),
              BlocBuilder<DreamsBloc, DreamsState>(
                builder: (context, state) {
                  return AppButton(
                    text: 'save_dream'.tr(),
                    isLoading: state.maybeWhen(
                      loading: () => true,
                      orElse: () => false,
                    ),
                    onPressed: () {
                      if (formKey.currentState?.saveAndValidate() ?? false) {
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
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
