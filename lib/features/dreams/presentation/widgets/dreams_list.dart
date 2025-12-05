import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tush/core/presentation/widgets/widgets.dart';
import 'package:tush/features/dreams/presentation/bloc/dreams_bloc.dart';
import 'package:tush/features/dreams/presentation/widgets/dream_list_item.dart';

class DreamsList extends StatelessWidget {
  final ScrollController scrollController;

  const DreamsList({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DreamsBloc, DreamsState>(
      builder: (context, state) {
        return state.maybeWhen(
          loading: () => const Center(child: CircularProgressIndicator()),
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
                    child: AppBodyMedium(text: 'no_dreams_yet'.tr()),
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
                      return DreamListItem(dream: dream);
                    },
                  ),
                );
              },
          failure: (message) => Center(child: AppBodyMedium(text: message)),
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}
