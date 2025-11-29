import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tush/features/dreams/presentation/bloc/dreams_bloc.dart';
import 'package:tush/features/dreams/presentation/widgets/add_dream_modal.dart';
import 'package:tush/routes/app_router.gr.dart';

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
    useEffect(() {
      context.read<DreamsBloc>().add(const DreamsEvent.load());
      return null;
    }, []);

    return BlocListener<DreamsBloc, DreamsState>(
      listener: (context, state) {
        state.maybeWhen(
          success: () {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('dream_saved_success'.tr())));
          },
          failure: (message) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(message)));
          },
          orElse: () {},
        );
      },
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(title: Text('home'.tr(context: context))),
            body: Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 12),
              child: BlocBuilder<DreamsBloc, DreamsState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    loaded: (dreams) {
                      if (dreams.isEmpty) {
                        return Center(child: Text('no_dreams_yet'.tr()));
                      }
                      return ListView.builder(
                        itemCount: dreams.length,
                        itemBuilder: (context, index) {
                          final dream = dreams[index];
                          return Card(
                            child: ListTile(
                              onTap: () {
                                context.router.push(
                                  DreamDetailRoute(dream: dream),
                                );
                              },
                              title: Text(dream.title),
                              subtitle: dream.isReady
                                  ? Text(
                                      dream.createdAt != null
                                          ? DateFormat.yMMMd().format(
                                              dream.createdAt!,
                                            )
                                          : '',
                                    )
                                  : Row(
                                      children: [
                                        const SizedBox(
                                          width: 12,
                                          height: 12,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text('processing'.tr()),
                                      ],
                                    ),
                            ),
                          );
                        },
                      );
                    },
                    failure: (message) => Center(child: Text(message)),
                    orElse: () => const SizedBox.shrink(),
                  );
                },
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
}
