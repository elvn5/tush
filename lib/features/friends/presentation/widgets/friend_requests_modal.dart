import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';
import 'package:tush/core/presentation/widgets/widgets.dart';
import '../bloc/friend_requests_bloc.dart';

class FriendRequestsModal extends StatelessWidget {
  const FriendRequestsModal({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => BlocProvider(
        create: (context) =>
            GetIt.I<FriendRequestsBloc>()
              ..add(const FriendRequestsEvent.load()),
        child: const FriendRequestsModal(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.3,
      maxChildSize: 0.9,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            children: [
              const Gap(8),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Theme.of(context).dividerColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const Gap(16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    AppTitleMedium(text: 'friend_requests'.tr()),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),
              const Gap(8),
              Expanded(
                child: BlocConsumer<FriendRequestsBloc, FriendRequestsState>(
                  listener: (context, state) {
                    state.maybeWhen(
                      accepted: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('friend_request_accepted'.tr()),
                          ),
                        );
                        context.read<FriendRequestsBloc>().add(
                          const FriendRequestsEvent.load(),
                        );
                      },
                      declined: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('friend_request_declined'.tr()),
                          ),
                        );
                        context.read<FriendRequestsBloc>().add(
                          const FriendRequestsEvent.load(),
                        );
                      },
                      error: (message) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(message)));
                      },
                      orElse: () {},
                    );
                  },
                  builder: (context, state) {
                    return state.maybeWhen(
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      loaded: (requests) {
                        if (requests.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.mail_outline,
                                  size: 64,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.primary.withValues(alpha: 0.5),
                                ),
                                const Gap(16),
                                AppBodyLarge(text: 'no_friend_requests'.tr()),
                              ],
                            ),
                          );
                        }
                        return ListView.builder(
                          controller: scrollController,
                          padding: const EdgeInsets.all(16),
                          itemCount: requests.length,
                          itemBuilder: (context, index) {
                            final request = requests[index];
                            return Card(
                              child: ListTile(
                                leading: CircleAvatar(
                                  child: Text(
                                    (request.name ?? request.email)[0]
                                        .toUpperCase(),
                                  ),
                                ),
                                title: Text(request.name ?? request.email),
                                subtitle: request.name != null
                                    ? Text(request.email)
                                    : null,
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.check_circle),
                                      color: Colors.green,
                                      tooltip: 'accept'.tr(),
                                      onPressed: () {
                                        context.read<FriendRequestsBloc>().add(
                                          FriendRequestsEvent.accept(
                                            senderId: request.id,
                                          ),
                                        );
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.cancel),
                                      color: Colors.red,
                                      tooltip: 'decline'.tr(),
                                      onPressed: () {
                                        context.read<FriendRequestsBloc>().add(
                                          FriendRequestsEvent.decline(
                                            senderId: request.id,
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      orElse: () => const SizedBox.shrink(),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
