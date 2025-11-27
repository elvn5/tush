import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:tush/core/presentation/bloc/theme_cubit.dart';

class SettingsSpeedDial extends StatelessWidget {
  const SettingsSpeedDial({super.key});

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      icon: Icons.settings,
      activeIcon: Icons.close,
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      activeBackgroundColor: Theme.of(context).colorScheme.error,
      activeForegroundColor: Theme.of(context).colorScheme.onError,
      visible: true,
      closeManually: false,
      curve: Curves.bounceIn,
      overlayColor: Colors.black,
      overlayOpacity: 0.5,
      elevation: 8.0,
      shape: const CircleBorder(),
      direction: SpeedDialDirection.up,
      children: [
        SpeedDialChild(
          child: const Icon(Icons.language),
          backgroundColor: Colors.blue,
          label: 'English',
          labelStyle: const TextStyle(fontSize: 18.0),
          onTap: () => context.setLocale(const Locale('en')),
        ),
        SpeedDialChild(
          child: const Icon(Icons.language),
          backgroundColor: Colors.red,
          label: 'Русский',
          labelStyle: const TextStyle(fontSize: 18.0),
          onTap: () => context.setLocale(const Locale('ru')),
        ),
        SpeedDialChild(
          child: const Icon(Icons.light_mode),
          backgroundColor: Colors.orange,
          label: 'Light Theme',
          labelStyle: const TextStyle(fontSize: 18.0),
          onTap: () => context.read<ThemeCubit>().setTheme(ThemeMode.light),
        ),
        SpeedDialChild(
          child: const Icon(Icons.dark_mode),
          backgroundColor: Colors.grey[800],
          label: 'Dark Theme',
          labelStyle: const TextStyle(fontSize: 18.0),
          onTap: () => context.read<ThemeCubit>().setTheme(ThemeMode.dark),
        ),
        SpeedDialChild(
          child: const Icon(Icons.smartphone),
          backgroundColor: Colors.green,
          label: 'System Theme',
          labelStyle: const TextStyle(fontSize: 18.0),
          onTap: () => context.read<ThemeCubit>().setTheme(ThemeMode.system),
        ),
      ],
    );
  }
}
