import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tush/core/presentation/bloc/theme_cubit.dart';

class LanguageSwitcherFab extends StatelessWidget {
  const LanguageSwitcherFab({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        final RenderBox button = context.findRenderObject() as RenderBox;
        final RenderBox overlay =
            Overlay.of(context).context.findRenderObject() as RenderBox;
        final RelativeRect position = RelativeRect.fromRect(
          Rect.fromPoints(
            button.localToGlobal(Offset.zero, ancestor: overlay),
            button.localToGlobal(
              button.size.bottomRight(Offset.zero),
              ancestor: overlay,
            ),
          ),
          Offset.zero & overlay.size,
        );

        showMenu<dynamic>(
          context: context,
          position: position,
          items: [
            const PopupMenuItem(
              enabled: false,
              child: Text(
                'Language',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const PopupMenuItem(value: Locale('en'), child: Text('English')),
            const PopupMenuItem(value: Locale('ru'), child: Text('Русский')),
            const PopupMenuDivider(),
            const PopupMenuItem(
              enabled: false,
              child: Text(
                'Theme',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const PopupMenuItem(value: ThemeMode.light, child: Text('Light')),
            const PopupMenuItem(value: ThemeMode.dark, child: Text('Dark')),
            const PopupMenuItem(value: ThemeMode.system, child: Text('System')),
          ],
        ).then((value) async {
          if (context.mounted && value != null) {
            if (value is Locale) {
              await context.setLocale(value);
            } else if (value is ThemeMode) {
              context.read<ThemeCubit>().setTheme(value);
            }
          }
        });
      },
      child: const Icon(Icons.settings),
    );
  }
}
