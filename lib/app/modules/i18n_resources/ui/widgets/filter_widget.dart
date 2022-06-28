import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pixlog_challenge/app/modules/i18n_resources/ui/bloc/dropdown_cubit.dart';
import 'package:pixlog_challenge/app/modules/i18n_resources/ui/bloc/filter_cubit.dart';
import 'package:pixlog_challenge/app/modules/i18n_resources/ui/bloc/resource_bloc.dart';
import 'package:pixlog_challenge/app/modules/i18n_resources/ui/bloc/resource_events.dart';
import 'package:pixlog_challenge/app/modules/i18n_resources/ui/widgets/filter_dropdownmenu_widget.dart';

class FilterWidget extends StatelessWidget {
  const FilterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final resourceBloc = Modular.get<ResourceBloc>();
    final filterCubit = Modular.get<FilterCubit>();
    final cubit = Modular.get<DropdownValueCubit>();
    final width = MediaQuery.of(context).size.width;

    return BlocBuilder<FilterCubit, bool>(
      bloc: filterCubit,
      builder: (context, state) => AnimatedContainer(
        color: Colors.grey[200],
        curve: Curves.fastOutSlowIn,
        duration: const Duration(milliseconds: 100),
        height: state ? null : 0,
        child: Column(children: [
          FilterDropdownMenu(
            value: cubit.state.language,
            items: resourceBloc.state.languages.isNotEmpty ? resourceBloc.state.languages : [''],            bloc: resourceBloc,
            text: "Filter by language:",
            onChanged: (String? lang) {
              if (lang != null) {
                cubit.filterBy(language: lang);
                resourceBloc.add(
                  ResourceFilterEvent(
                    languageFilter: lang,
                    moduleFilter: cubit.state.module,
                  ),
                );
              }
            },
          ),
          FilterDropdownMenu(
            value: cubit.state.module,
            items: resourceBloc.state.modules.isNotEmpty ? resourceBloc.state.modules : [''],
            bloc: resourceBloc,
            text: "Filter by module:",
            onChanged: (String? module) {
              if (module != null) {
                cubit.filterBy(module: module);
                resourceBloc.add(
                  ResourceFilterEvent(
                    moduleFilter: module,
                    languageFilter: cubit.state.language,
                  ),
                );
              }
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * .1),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'value',
              ),
              onChanged: (String filter) => resourceBloc.add(
                ResourceFilterEvent(
                  moduleFilter: cubit.state.module,
                  languageFilter: cubit.state.language,
                  valueFilter: filter,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
              child: const Text("Clean filters"),
              onPressed: () {
                cubit.cleanFilters();
                resourceBloc.add(ResourceFilterEvent());
              },
            ),
          ),
        ]),
      ),
    );
  }
}
