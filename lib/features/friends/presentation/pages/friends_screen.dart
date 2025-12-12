import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';
import 'package:tush/core/presentation/widgets/widgets.dart';
import '../bloc/friends_bloc.dart';

@RoutePage()
class FriendsScreen extends HookWidget {
  const FriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I<FriendsBloc>(),
      child: const _FriendsBody(),
    );
  }
}

class _FriendsBody extends HookWidget {
  const _FriendsBody();

  @override
  Widget build(BuildContext context) {
    final tabController = useTabController(initialLength: 2);

    return BlocListener<FriendsBloc, FriendsState>(
      listener: (context, state) {
        state.maybeWhen(
          friendAdded: () {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('friend_added'.tr())));
            // Refresh friends list after adding
            context.read<FriendsBloc>().add(const FriendsEvent.loadFriends());
          },
          friendRemoved: () {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('friend_removed'.tr())));
            // Refresh friends list after removing
            context.read<FriendsBloc>().add(const FriendsEvent.loadFriends());
          },
          error: (message) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(message)));
          },
          orElse: () {},
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('friends'.tr()),
          bottom: TabBar(
            controller: tabController,
            tabs: [
              Tab(text: 'search'.tr()),
              Tab(text: 'my_friends'.tr()),
            ],
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: const [_SearchTab(), _MyFriendsTab()],
        ),
      ),
    );
  }
}

class _SearchTab extends HookWidget {
  const _SearchTab();

  @override
  Widget build(BuildContext context) {
    final searchController = useTextEditingController();
    final debouncer = useMemoized(() => Debouncer(milliseconds: 500));

    useEffect(() {
      void listener() {
        debouncer.run(() {
          context.read<FriendsBloc>().add(
            FriendsEvent.searchUsers(query: searchController.text),
          );
        });
      }

      searchController.addListener(listener);
      return () => searchController.removeListener(listener);
    }, [searchController]);

    return Column(
      children: [
        // Search Bar
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: AppTextField(
            controller: searchController,
            label: 'search_friends_hint'.tr(),
            prefixIcon: const Icon(Icons.search),
            suffixIcon: searchController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      searchController.clear();
                      context.read<FriendsBloc>().add(
                        const FriendsEvent.clearSearch(),
                      );
                    },
                  )
                : null,
          ),
        ),
        // Results
        Expanded(
          child: BlocBuilder<FriendsBloc, FriendsState>(
            builder: (context, state) {
              return state.maybeWhen(
                initial: () => _buildSearchInitialState(context),
                searching: () =>
                    const Center(child: CircularProgressIndicator()),
                addingFriend: () =>
                    const Center(child: CircularProgressIndicator()),
                searchResults: (users) => ListView.builder(
                  itemCount: users.length,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text(
                            (user.name ?? user.email)[0].toUpperCase(),
                          ),
                        ),
                        title: Text(user.name ?? user.email),
                        subtitle: user.name != null ? Text(user.email) : null,
                        trailing: IconButton(
                          icon: const Icon(Icons.person_add),
                          tooltip: 'add_friend'.tr(),
                          onPressed: () {
                            context.read<FriendsBloc>().add(
                              FriendsEvent.addFriend(friendId: user.id),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
                empty: () => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search_off,
                        size: 64,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.5),
                      ),
                      const Gap(16),
                      AppBodyLarge(text: 'no_users_found'.tr()),
                    ],
                  ),
                ),
                orElse: () => const SizedBox.shrink(),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSearchInitialState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search,
            size: 80,
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.5),
          ),
          const Gap(16),
          AppBodyLarge(
            text: 'search_friends_hint'.tr(),
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ],
      ),
    );
  }
}

class _MyFriendsTab extends HookWidget {
  const _MyFriendsTab();

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      context.read<FriendsBloc>().add(const FriendsEvent.loadFriends());
      return null;
    }, []);

    return BlocBuilder<FriendsBloc, FriendsState>(
      builder: (context, state) {
        return state.maybeWhen(
          loadingFriends: () =>
              const Center(child: CircularProgressIndicator()),
          friendsLoaded: (friends) {
            if (friends.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.people_outline,
                      size: 80,
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withValues(alpha: 0.5),
                    ),
                    const Gap(16),
                    AppBodyLarge(text: 'no_friends_yet'.tr()),
                  ],
                ),
              );
            }
            return RefreshIndicator(
              onRefresh: () async {
                context.read<FriendsBloc>().add(
                  const FriendsEvent.loadFriends(),
                );
              },
              child: ListView.builder(
                itemCount: friends.length,
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  final friend = friends[index];
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(
                          (friend.name ?? friend.email)[0].toUpperCase(),
                        ),
                      ),
                      title: Text(friend.name ?? friend.email),
                      subtitle: friend.name != null ? Text(friend.email) : null,
                      trailing: IconButton(
                        icon: const Icon(Icons.person_remove),
                        tooltip: 'remove_friend'.tr(),
                        onPressed: () {
                          context.read<FriendsBloc>().add(
                            FriendsEvent.removeFriend(friendId: friend.id),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            );
          },
          orElse: () => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.people_outline,
                  size: 80,
                  color: Theme.of(
                    context,
                  ).colorScheme.primary.withValues(alpha: 0.5),
                ),
                const Gap(16),
                AppBodyLarge(text: 'no_friends_yet'.tr()),
              ],
            ),
          ),
        );
      },
    );
  }
}

class Debouncer {
  final int milliseconds;
  VoidCallback? _action;

  Debouncer({required this.milliseconds});

  void run(VoidCallback action) {
    _action = action;
    Future.delayed(Duration(milliseconds: milliseconds), () {
      if (_action == action) {
        action();
      }
    });
  }
}
