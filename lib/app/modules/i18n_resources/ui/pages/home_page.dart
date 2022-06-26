import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pixlog_challenge/app/modules/i18n_resources/ui/bloc/resource_bloc.dart';
import 'package:pixlog_challenge/app/modules/i18n_resources/ui/bloc/resource_events.dart';
import 'package:pixlog_challenge/app/modules/i18n_resources/ui/bloc/resource_state.dart';

class HomePage extends StatelessWidget {
  final bloc = Modular.get<ResourceBloc>();

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Translation resources"),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt),
            onPressed: () => print('--------------- filter widget appears now'),
          )
        ],
      ),
      body: BlocBuilder<ResourceBloc, ResourceState>(
        bloc: bloc,
        builder: (context, state) {
          // Emmit event to fetch resources
          bloc.add(ResourceFetchedEvent());

          switch (state.status) {
            // On failure
            // When the http request fails
            case ResourceStatus.failure:
              return const Center(child: Text('failed to fetch posts'));

            // On success
            // When the http request return the list of resources
            case ResourceStatus.success:
              return ListView.builder(
                itemCount: state.resources.length,
                itemBuilder: ((_, index) {
                  final resource = state.resources[index];

                  return ListTile(
                    leading: Text(resource.languageId),
                    title: Text(resource.resourceId),
                    trailing: Text(resource.updatedAt.toString()),
                    subtitle: Text(resource.value),
                    isThreeLine: true,
                  );
                }),
              );

            // On loading
            // When the http request or filter is still processing
            default:
              return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
