import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tush/features/dreams/presentation/bloc/dreams_bloc.dart';
import 'package:tush/features/dreams/presentation/widgets/add_dream_modal.dart';
import 'package:tush/core/presentation/widgets/widgets.dart';
import 'package:tush/features/dreams/presentation/widgets/dreams_list.dart';
import 'package:tush/features/dreams/presentation/widgets/home_filters.dart';
import 'package:tush/features/friends/presentation/widgets/friend_requests_modal.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I<DreamsBloc>(),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends HookWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();

    useEffect(() {
      context.read<DreamsBloc>().add(const DreamsEvent.started());

      void onScroll() {
        if (_isBottom(scrollController)) {
          context.read<DreamsBloc>().add(const DreamsEvent.loadMore());
        }
      }

      scrollController.addListener(onScroll);
      return () => scrollController.removeListener(onScroll);
    }, [scrollController]);

    return BlocListener<DreamsBloc, DreamsState>(
      listener: (context, state) {
        state.maybeWhen(
          failure: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: AppBodyMedium(text: message, color: Colors.white),
              ),
            );
          },
          orElse: () {},
        );
      },
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: AppTitleMedium(text: 'home'.tr(context: context)),
              actions: [
                IconButton(
                  icon: const Icon(Icons.notifications_outlined),
                  tooltip: 'friend_requests'.tr(),
                  onPressed: () => FriendRequestsModal.show(context),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  // const HomeSearchBar(),
                  const HomeFilters(),
                  Expanded(
                    child: DreamsList(scrollController: scrollController),
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (modalContext) {
                    return BlocProvider.value(
                      value: context.read<DreamsBloc>(),
                      child: const AddDreamModal(),
                    );
                  },
                );
              },
              child: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }

  bool _isBottom(ScrollController controller) {
    if (!controller.hasClients) return false;
    final maxScroll = controller.position.maxScrollExtent;
    final currentScroll = controller.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
