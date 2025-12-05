import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tush/features/dreams/presentation/bloc/dreams_bloc.dart';

class HomeSearchBar extends HookWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = useTextEditingController();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          hintText: 'search_dreams'.tr(),
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onChanged: (value) {
          context.read<DreamsBloc>().add(DreamsEvent.searchChanged(value));
        },
      ),
    );
  }
}
