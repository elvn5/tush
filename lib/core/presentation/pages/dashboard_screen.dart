import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tush/routes/app_router.gr.dart';

@RoutePage()
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        HomeRoute(),
        ProfileRoute(),
        FriendsRoute(),
        SettingsRoute(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 8.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(
                  tabsRouter.activeIndex == 0
                      ? Icons.home
                      : Icons.home_outlined,
                  color: tabsRouter.activeIndex == 0
                      ? Theme.of(context).colorScheme.primary
                      : null,
                ),
                onPressed: () => tabsRouter.setActiveIndex(0),
                tooltip: 'home'.tr(context: context),
              ),
              IconButton(
                icon: Icon(
                  tabsRouter.activeIndex == 1
                      ? Icons.person
                      : Icons.person_outline,
                  color: tabsRouter.activeIndex == 1
                      ? Theme.of(context).colorScheme.primary
                      : null,
                ),
                onPressed: () => tabsRouter.setActiveIndex(1),
                tooltip: 'profile'.tr(context: context),
              ),
              IconButton(
                icon: Icon(
                  tabsRouter.activeIndex == 2
                      ? Icons.people
                      : Icons.people_outline,
                  color: tabsRouter.activeIndex == 2
                      ? Theme.of(context).colorScheme.primary
                      : null,
                ),
                onPressed: () => tabsRouter.setActiveIndex(2),
                tooltip: 'friends'.tr(context: context),
              ),
              IconButton(
                icon: Icon(
                  tabsRouter.activeIndex == 3
                      ? Icons.settings
                      : Icons.settings_outlined,
                  color: tabsRouter.activeIndex == 3
                      ? Theme.of(context).colorScheme.primary
                      : null,
                ),
                onPressed: () => tabsRouter.setActiveIndex(3),
                tooltip: 'settings'.tr(context: context),
              ),
            ],
          ),
        );
      },
    );
  }
}
