import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';
import 'package:tush/core/presentation/widgets/widgets.dart';
import 'package:tush/features/dreams/domain/entities/dream.dart';
import 'package:tush/features/dreams/domain/repositories/dreams_repository.dart';
import 'package:tush/routes/app_router.gr.dart';

@RoutePage()
class FriendDreamsScreen extends HookWidget {
  final String friendId;
  final String friendName;
  final String friendEmail;

  const FriendDreamsScreen({
    super.key,
    required this.friendId,
    required this.friendName,
    required this.friendEmail,
  });

  @override
  Widget build(BuildContext context) {
    final dreams = useState<List<Dream>>([]);
    final isLoading = useState(true);
    final isLoadingMore = useState(false);
    final nextCursor = useState<String?>(null);
    final error = useState<String?>(null);
    final scrollController = useScrollController();

    final repository = useMemoized(() => GetIt.I<DreamsRepository>());

    Future<void> loadDreams({bool loadMore = false}) async {
      if (loadMore && nextCursor.value == null) return;
      if (loadMore) {
        isLoadingMore.value = true;
      } else {
        isLoading.value = true;
        error.value = null;
      }

      try {
        final result = await repository.getFriendDreams(
          friendId: friendId,
          cursor: loadMore ? nextCursor.value : null,
        );
        if (loadMore) {
          dreams.value = [...dreams.value, ...result.items];
        } else {
          dreams.value = result.items;
        }
        nextCursor.value = result.nextCursor;
      } catch (e) {
        error.value = e.toString();
      } finally {
        isLoading.value = false;
        isLoadingMore.value = false;
      }
    }

    useEffect(() {
      loadDreams();

      void onScroll() {
        if (!scrollController.hasClients) return;
        final maxScroll = scrollController.position.maxScrollExtent;
        final currentScroll = scrollController.offset;
        if (currentScroll >= (maxScroll * 0.9) && !isLoadingMore.value) {
          loadDreams(loadMore: true);
        }
      }

      scrollController.addListener(onScroll);
      return () => scrollController.removeListener(onScroll);
    }, []);

    final displayName = friendName.isNotEmpty ? friendName : friendEmail;

    return Scaffold(
      appBar: AppBar(title: Text('${'friend_dreams'.tr()}: $displayName')),
      body: _buildBody(
        context: context,
        dreams: dreams.value,
        isLoading: isLoading.value,
        isLoadingMore: isLoadingMore.value,
        error: error.value,
        scrollController: scrollController,
        onRetry: () => loadDreams(),
      ),
    );
  }

  Widget _buildBody({
    required BuildContext context,
    required List<Dream> dreams,
    required bool isLoading,
    required bool isLoadingMore,
    required String? error,
    required ScrollController scrollController,
    required VoidCallback onRetry,
  }) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const Gap(16),
            AppBodyLarge(text: 'error_loading_dreams'.tr()),
            const Gap(8),
            ElevatedButton(onPressed: onRetry, child: Text('retry'.tr())),
          ],
        ),
      );
    }

    if (dreams.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.nights_stay_outlined,
              size: 80,
              color: Theme.of(
                context,
              ).colorScheme.primary.withValues(alpha: 0.5),
            ),
            const Gap(16),
            AppBodyLarge(text: 'no_friend_dreams'.tr()),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        onRetry();
      },
      child: ListView.builder(
        controller: scrollController,
        padding: const EdgeInsets.all(16),
        itemCount: dreams.length + (isLoadingMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == dreams.length) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(),
              ),
            );
          }

          final dream = dreams[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              title: Text(
                dream.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dream.text,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (dream.createdAt != null) ...[
                    const Gap(4),
                    Text(
                      DateFormat.yMMMd(
                        context.locale.languageCode,
                      ).format(dream.createdAt!),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ],
              ),
              trailing: dream.isReady
                  ? Icon(
                      Icons.auto_awesome,
                      color: Theme.of(context).colorScheme.primary,
                    )
                  : const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
              onTap: () {
                context.router.push(DreamDetailRoute(dream: dream));
              },
            ),
          );
        },
      ),
    );
  }
}
