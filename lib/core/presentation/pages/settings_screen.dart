import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:tush/core/presentation/bloc/theme_cubit.dart';
import 'package:tush/core/presentation/widgets/widgets.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'settings'.tr(context: context),
        ), // Ensure 'settings' key exists or use a hardcoded fallback for now
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          AppTitleLarge(
            text: 'language'.tr(context: context),
          ), // Ensure 'language' key exists
          const Gap(10),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.language),
                  title: const Text('English'),
                  trailing: context.locale.languageCode == 'en'
                      ? const Icon(Icons.check, color: Colors.green)
                      : null,
                  onTap: () => context.setLocale(const Locale('en')),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.language),
                  title: const Text('Русский'),
                  trailing: context.locale.languageCode == 'ru'
                      ? const Icon(Icons.check, color: Colors.green)
                      : null,
                  onTap: () => context.setLocale(const Locale('ru')),
                ),
              ],
            ),
          ),
          const Gap(20),
          AppTitleLarge(
            text: 'theme'.tr(context: context),
          ), // Ensure 'theme' key exists
          const Gap(10),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.light_mode),
                  title: const Text('Light'),
                  onTap: () =>
                      context.read<ThemeCubit>().setTheme(ThemeMode.light),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.dark_mode),
                  title: const Text('Dark'),
                  onTap: () =>
                      context.read<ThemeCubit>().setTheme(ThemeMode.dark),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.smartphone),
                  title: const Text('System'),
                  onTap: () =>
                      context.read<ThemeCubit>().setTheme(ThemeMode.system),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
