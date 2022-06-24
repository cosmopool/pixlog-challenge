import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pixlog_challenge/app/modules/i18n_resources/domain/entity/resource_entity.dart';
import 'package:pixlog_challenge/app/modules/i18n_resources/domain/interfaces/resources_repository_interface.dart';
import 'package:pixlog_challenge/app/modules/i18n_resources/domain/usecases/get_resources_usecase.dart';

import '../../../../../stubs/entity_list.dart';

class MockResourcesRepository extends Mock implements ResourcesRepositoryInterface {}

late ResourcesRepositoryInterface repository;
late GetResourcesUsecase usecase;

void main() async {
  setUp(() async {
    repository = MockResourcesRepository();
    usecase = GetResourcesUsecase(repository);
  });

  test('Should return a list of resources', () async {
    when(repository.fetch).thenAnswer((_) async => entityList);
    final response = await usecase();
    expect(response.runtimeType, List<ResourceEntity>);
  });

  test('Should call repository fetch method once', () async {
    when(repository.fetch).thenAnswer((_) async => entityList);
    await usecase();
    verify(() => repository.fetch()).called(1);
  });
}
