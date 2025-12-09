import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tush/features/dreams/domain/entities/dream.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:tush/features/dreams/presentation/bloc/dreams_bloc.dart';

@RoutePage()
class DreamDetailScreen extends StatelessWidget {
  final Dream dream;

  const DreamDetailScreen({super.key, required this.dream});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I<DreamsBloc>(),
      child: BlocConsumer<DreamsBloc, DreamsState>(
        listener: (context, state) {
          state.maybeWhen(
            loaded:
                (
                  dreams,
                  nextCursor,
                  hasReachedMax,
                  isLoadingMore,
                  searchQuery,
                  statusFilter,
                  startDateFilter,
                  endDateFilter,
                  isAdded,
                  isDeleted,
                  isSaving,
                ) {
                  if (isDeleted) {
                    context.router.pop(true);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('dream_deleted'.tr())),
                    );
                  }
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
            appBar: AppBar(title: Text('your_dream'.tr())),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dream.title,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  if (dream.createdAt != null)
                    Text(
                      DateFormat.yMMMd().add_jm().format(dream.createdAt!),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  const SizedBox(height: 16),
                  Text(
                    dream.text,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  if (dream.interpretation != null &&
                      dream.interpretation!.isNotEmpty) ...[
                    const SizedBox(height: 24),
                    Text(
                      'interpretation'.tr(),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: MarkdownWidget(
                        data: dream.interpretation!,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        config: MarkdownConfig(
                          configs: [
                            TableConfig(
                              wrapper: (child) => SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: child,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text('delete_dream'.tr()),
          content: Text('delete_dream_confirmation'.tr()),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text('cancel'.tr()),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                context.read<DreamsBloc>().add(DreamsEvent.delete(dream.id));
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
