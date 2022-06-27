import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pixlog_challenge/app/modules/i18n_resources/domain/usecases/get_resources_usecase.dart';
import 'package:pixlog_challenge/app/modules/i18n_resources/external/mappers/resources_mapper.dart';
import 'package:pixlog_challenge/app/modules/i18n_resources/ui/bloc/resource_bloc.dart';
import 'package:pixlog_challenge/app/modules/i18n_resources/ui/bloc/resource_events.dart';
import 'package:pixlog_challenge/app/modules/i18n_resources/ui/bloc/resource_state.dart';
import 'package:test/test.dart';

import '../../../../../stubs/resources_response.dart';

class MockUsecase extends Mock implements GetResourcesUsecase {}

late GetResourcesUsecase usecase;
late ResourceBloc resourceBloc;
final listOfEntities = ResourcesMapper.fromList(resourcesResponse);

void main() async {
  setUp(() async {
    usecase = MockUsecase();
    resourceBloc = ResourceBloc(usecase);
  });

  blocTest(
    'Should return a list of entities on fetch',
    build: () {
      when(usecase.call).thenAnswer((_) async => listOfEntities);
      return resourceBloc;
    },
    act: (ResourceBloc bloc) => bloc.add(ResourceFetchedEvent()),
    expect: () => [
      ResourceState(status: ResourceStatus.success, resources: listOfEntities)
    ],
  );

  blocTest(
    'Should return a list with only languageId: fr resources',
    build: () => resourceBloc,
    seed: () => ResourceState(
      status: ResourceStatus.success,
      resources: listOfEntities,
      cache: listOfEntities,
    ),
    act: (ResourceBloc bloc) =>
        bloc.add(ResourceFilterEvent(languageFilter: "fr")),
    expect: () => [
      ResourceState(
        status: ResourceStatus.success,
        resources: [listOfEntities[3]],
      )
    ],
  );

  blocTest(
    'Should return a list with only moduleId: RedMileTrack resources',
    build: () => resourceBloc,
    seed: () => ResourceState(
      status: ResourceStatus.success,
      resources: listOfEntities,
      cache: listOfEntities,
    ),
    act: (ResourceBloc bloc) =>
        bloc.add(ResourceFilterEvent(moduleFilter: "RedMileTrack")),
    expect: () => [
      ResourceState(
        status: ResourceStatus.success,
        resources: [listOfEntities[10], listOfEntities[11]],
      )
    ],
  );

  blocTest(
    'Should return a list with only moduleId: RedMileTrack and languageId: es resources',
    build: () => resourceBloc,
    seed: () => ResourceState(
      status: ResourceStatus.success,
      resources: listOfEntities,
      cache: listOfEntities,
    ),
    act: (ResourceBloc bloc) => bloc.add(
      ResourceFilterEvent(
        moduleFilter: "RedMileTrack",
        languageFilter: "es",
      ),
    ),
    expect: () => [
      ResourceState(
        status: ResourceStatus.success,
        resources: [listOfEntities[11]],
      )
    ],
  );

  blocTest(
    'Should return a list with resources with values that contains "cc"',
    build: () => resourceBloc,
    seed: () => ResourceState(
      status: ResourceStatus.success,
      resources: listOfEntities,
      cache: listOfEntities,
    ),
    act: (ResourceBloc bloc) => bloc.add(
      ResourceFilterEvent(
        valueFilter: "cc",
      ),
    ),
    expect: () => [
      ResourceState(
        status: ResourceStatus.success,
        resources: [listOfEntities[5], listOfEntities[8], listOfEntities[11]],
      )
    ],
  );

  blocTest(
    'Should return a list with resources filtered by all filters',
    build: () => resourceBloc,
    seed: () => ResourceState(
      status: ResourceStatus.success,
      resources: listOfEntities,
      cache: listOfEntities,
    ),
    act: (ResourceBloc bloc) => bloc.add(
      ResourceFilterEvent(
        languageFilter: "es",
        moduleFilter: "RedMileTrack",
        valueFilter: "cc",
      ),
    ),
    expect: () => [
      ResourceState(
        status: ResourceStatus.success,
        resources: [listOfEntities[11]],
      )
    ],
  );

  blocTest(
    'Should return no resource',
    build: () => resourceBloc,
    seed: () => ResourceState(
      status: ResourceStatus.success,
      resources: listOfEntities,
      cache: listOfEntities,
    ),
    act: (ResourceBloc bloc) => bloc.add(
      ResourceFilterEvent(
        languageFilter: "es",
        moduleFilter: "RedMileTrack",
        valueFilter: "asdfasdfasdfasdf",
      ),
    ),
    expect: () => [
      const ResourceState(
        status: ResourceStatus.success,
        resources: [],
      )
    ],
  );
}
