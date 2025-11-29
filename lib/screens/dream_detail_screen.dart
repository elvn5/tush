import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tush/features/dreams/domain/entities/dream.dart';

@RoutePage()
class DreamDetailScreen extends StatelessWidget {
  final Dream dream;

  const DreamDetailScreen({super.key, required this.dream});

  @override
  Widget build(BuildContext context) {
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
            Text(dream.text, style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }
}
