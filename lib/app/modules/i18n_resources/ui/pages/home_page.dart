import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pixlog_challenge/app/modules/i18n_resources/ui/bloc/dropdown_cubit.dart';
import 'package:pixlog_challenge/app/modules/i18n_resources/ui/bloc/filter_cubit.dart';
import 'package:pixlog_challenge/app/modules/i18n_resources/ui/bloc/resource_bloc.dart';
import 'package:pixlog_challenge/app/modules/i18n_resources/ui/bloc/resource_events.dart';
import 'package:pixlog_challenge/app/modules/i18n_resources/ui/bloc/resource_state.dart';
import 'package:pixlog_challenge/app/modules/i18n_resources/ui/widgets/filter_widget.dart';

class HomePage extends StatelessWidget {
  final bloc = Modular.get<ResourceBloc>();
  final cubit = Modular.get<DropdownValueCubit>();
  final filterWidgetCubit = Modular.get<FilterCubit>();

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Translation resources"),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt),
            onPressed: () {
              // first we verify if data has loaded to only then show the filters
              if (bloc.state.status == ResourceStatus.success) {
                filterWidgetCubit.toggleVisibility();
              } else {
                const snack = SnackBar(
                  content: Text("Data still loading, please try again later!"),
                );
                ScaffoldMessenger.of(context).showSnackBar(snack);
              }
            },
          )
        ],
      ),
      body: Column(
        children: [
          const FilterWidget(),
          Expanded(
            child: BlocBuilder<ResourceBloc, ResourceState>(
              bloc: bloc,
              builder: (context, state) {
                switch (state.status) {
                  // On failure
                  // When the http request fails
                  case ResourceStatus.failure:
                    return Center(
                        child: Column(
                      children: [
                        Text(state.error),
                        ElevatedButton(
                          onPressed: () => bloc.add(ResourceFetchedEvent()),
                          child: const Padding(
                            padding: EdgeInsets.all(10),
                            child: Text("Try again"),
                          ),
                        )
                      ],
                    ));

                  // On success
                  // When the http request return the list of resources
                  case ResourceStatus.success:
                    return ListView.builder(
                      itemCount: state.resources.length,
                      itemBuilder: ((_, index) {
                        final resource = state.resources[index];

                        return Card(
                          child: Column(
                            children: [
                              ListTile(
                                leading: Text(resource.languageId),
                                title: Text(resource.resourceId),
                              ),
                              ListTile(
                                leading: const SizedBox(width: 5),
                                title: Text(resource.value),
                                subtitle: Text(resource.updatedAt.toString()),
                              ),
                            ],
                          ),
                        );
                      }),
                    );

                  // On loading
                  // When the http request or filter is still processing
                  case ResourceStatus.loading:
                    return const Center(child: CircularProgressIndicator());

                  // On initial
                  default:
                    // Emmit event to fetch resources
                    cubit.cleanFilters();
                    bloc.add(ResourceFetchedEvent());
                    return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
