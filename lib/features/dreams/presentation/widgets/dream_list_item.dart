import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tush/core/presentation/widgets/widgets.dart';
import 'package:tush/core/utils/date_formatter.dart';
import 'package:tush/features/dreams/domain/entities/dream.dart';
import 'package:tush/features/dreams/presentation/bloc/dreams_bloc.dart';
import 'package:tush/routes/app_router.gr.dart';

class DreamListItem extends StatelessWidget {
  final Dream dream;

  const DreamListItem({super.key, required this.dream});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () async {
          final result = await context.router.push(
            DreamDetailRoute(dream: dream),
          );
          if (result == true && context.mounted) {
            context.read<DreamsBloc>().add(const DreamsEvent.refresh());
          }
        },
        title: AppTitleSmall(text: dream.title),
        subtitle: dream.isReady
            ? AppBodySmall(
                text: dream.createdAt != null
                    ? AppDateFormatter.format(dream.createdAt!, context)
                    : '',
              )
            : Row(
                children: [
                  const SizedBox(
                    width: 12,
                    height: 12,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  const SizedBox(width: 8),
                  AppBodySmall(text: 'processing'.tr()),
                ],
              ),
      ),
    );
  }
}
