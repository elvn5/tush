import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tush/features/dreams/presentation/bloc/dreams_bloc.dart';
import 'package:tush/features/dreams/presentation/widgets/add_dream_modal.dart';
import 'package:tush/routes/app_router.gr.dart';
import 'package:tush/core/presentation/widgets/widgets.dart';

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
    final searchController = useTextEditingController();

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
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  // Search Bar
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'Search dreams...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onChanged: (value) {
                        context.read<DreamsBloc>().add(
                          DreamsEvent.searchChanged(value),
                        );
                      },
                    ),
                  ),
                  // Filters
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        const SizedBox(width: 8),
                        BlocBuilder<DreamsBloc, DreamsState>(
                          builder: (context, state) {
                            return state.maybeWhen(
                              loaded:
                                  (
                                    dreams,
                                    nextCursor,
                                    hasReachedMax,
                                    isLoadingMore,
                                    searchQuery,
                                    statusFilter,
                                    startDateFilter,
                                    endDateFilter,
                                    isAdded,
                                    isDeleted,
                                  ) {
                                    final hasDateFilter =
                                        startDateFilter != null ||
                                        endDateFilter != null;
                                    return FilterChip(
                                      label: AppBodySmall(
                                        text: hasDateFilter
                                            ? '${startDateFilter != null ? DateFormat.yMd().format(startDateFilter) : ''} - ${endDateFilter != null ? DateFormat.yMd().format(endDateFilter) : ''}'
                                            : 'filter_by_date'.tr(),
                                      ),
                                      selected: hasDateFilter,
                                      onSelected: (selected) async {
                                        if (selected) {
                                          final dateRange =
                                              await showDateRangePicker(
                                                context: context,
                                                firstDate: DateTime(2020),
                                                lastDate: DateTime.now(),
                                                initialDateRange:
                                                    startDateFilter != null &&
                                                        endDateFilter != null
                                                    ? DateTimeRange(
                                                        start: startDateFilter,
                                                        end: endDateFilter,
                                                      )
                                                    : null,
                                              );
                                          if (dateRange != null &&
                                              context.mounted) {
                                            // Adjust end date to end of day (23:59:59.999)
                                            // to include all dreams created on the selected end date
                                            final adjustedEndDate = DateTime(
                                              dateRange.end.year,
                                              dateRange.end.month,
                                              dateRange.end.day,
                                              23,
                                              59,
                                              59,
                                              999,
                                            );
                                            context.read<DreamsBloc>().add(
                                              DreamsEvent.filterChanged(
                                                startDate: dateRange.start,
                                                endDate: adjustedEndDate,
                                              ),
                                            );
                                          }
                                        } else {
                                          context.read<DreamsBloc>().add(
                                            const DreamsEvent.filterChanged(
                                              startDate: null,
                                              endDate: null,
                                            ),
                                          );
                                        }
                                      },
                                      deleteIcon: hasDateFilter
                                          ? const Icon(Icons.close, size: 18)
                                          : null,
                                      onDeleted: hasDateFilter
                                          ? () {
                                              context.read<DreamsBloc>().add(
                                                const DreamsEvent.filterChanged(
                                                  startDate: null,
                                                  endDate: null,
                                                ),
                                              );
                                            }
                                          : null,
                                    );
                                  },
                              orElse: () => const SizedBox.shrink(),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: BlocBuilder<DreamsBloc, DreamsState>(
                      builder: (context, state) {
                        return state.maybeWhen(
                          loading: () =>
                              const Center(child: CircularProgressIndicator()),
                          loaded:
                              (
                                dreams,
                                nextCursor,
                                hasReachedMax,
                                isLoadingMore,
                                p1,
                                p2,
                                p3,
                                p4,
                                p5,
                                p6,
                              ) {
                                if (dreams.isEmpty) {
                                  return Center(
                                    child: AppBodyMedium(
                                      text: 'no_dreams_yet'.tr(),
                                    ),
                                  );
                                }
                                return RefreshIndicator(
                                  onRefresh: () async {
                                    final completer = Completer<void>();
                                    context.read<DreamsBloc>().add(
                                      DreamsEvent.refresh(completer),
                                    );
                                    return completer.future;
                                  },
                                  child: ListView.builder(
                                    controller: scrollController,
                                    itemCount: hasReachedMax
                                        ? dreams.length
                                        : dreams.length + 1,
                                    itemBuilder: (context, index) {
                                      if (index >= dreams.length) {
                                        return const Center(
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: CircularProgressIndicator(),
                                          ),
                                        );
                                      }
                                      final dream = dreams[index];
                                      return Card(
                                        child: ListTile(
                                          onTap: () async {
                                            final result = await context.router
                                                .push(
                                                  DreamDetailRoute(
                                                    dream: dream,
                                                  ),
                                                );
                                            if (result == true &&
                                                context.mounted) {
                                              context.read<DreamsBloc>().add(
                                                const DreamsEvent.refresh(),
                                              );
                                            }
                                          },
                                          title: AppTitleMedium(
                                            text: dream.title,
                                          ),
                                          subtitle: dream.isReady
                                              ? AppBodySmall(
                                                  text: dream.createdAt != null
                                                      ? DateFormat.yMMMd()
                                                            .format(
                                                              dream.createdAt!,
                                                            )
                                                      : '',
                                                )
                                              : Row(
                                                  children: [
                                                    const SizedBox(
                                                      width: 12,
                                                      height: 12,
                                                      child:
                                                          CircularProgressIndicator(
                                                            strokeWidth: 2,
                                                          ),
                                                    ),
                                                    const SizedBox(width: 8),
                                                    AppBodySmall(
                                                      text: 'processing'.tr(),
                                                    ),
                                                  ],
                                                ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                          failure: (message) =>
                              Center(child: AppBodyMedium(text: message)),
                          orElse: () => const SizedBox.shrink(),
                        );
                      },
                    ),
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
