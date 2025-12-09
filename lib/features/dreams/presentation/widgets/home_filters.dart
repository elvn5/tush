import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tush/core/presentation/widgets/widgets.dart';
import 'package:tush/features/dreams/presentation/bloc/dreams_bloc.dart';

class HomeFilters extends StatelessWidget {
  const HomeFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                      isSaving,
                    ) {
                      final hasDateFilter =
                          startDateFilter != null || endDateFilter != null;
                      return FilterChip(
                        label: AppBodySmall(
                          text: hasDateFilter
                              ? '${startDateFilter != null ? DateFormat.yMd().format(startDateFilter) : ''} - ${endDateFilter != null ? DateFormat.yMd().format(endDateFilter) : ''}'
                              : 'filter_by_date'.tr(),
                        ),
                        selected: hasDateFilter,
                        onSelected: (selected) async {
                          if (selected) {
                            final dateRange = await showDateRangePicker(
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
                            if (dateRange != null && context.mounted) {
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
    );
  }
}
