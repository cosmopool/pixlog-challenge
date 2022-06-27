import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pixlog_challenge/app/modules/i18n_resources/domain/entity/resource_entity.dart';
import 'package:pixlog_challenge/app/modules/i18n_resources/domain/interfaces/resources_repository_interface.dart';
import 'package:pixlog_challenge/app/modules/i18n_resources/external/local/hive_datasource.dart';
import 'package:pixlog_challenge/app/modules/i18n_resources/infra/interfaces/resources_datasource_interface.dart';
import 'package:pixlog_challenge/app/modules/i18n_resources/infra/repositories/resources_repository.dart';

import '../../../../../stubs/entity_list.dart';


class MockResourcesDatasource extends Mock implements IResourcesDatasource {}
class MockCacheDatasource extends Mock implements HiveDatasource {}

late IResourcesRepository repository;
late IResourcesDatasource datasource;
late HiveDatasource cache;

void main() async {
  setUp(() async {
    datasource = MockResourcesDatasource();
    cache = MockCacheDatasource();
    repository = ResourcesRepository(datasource, cache);

    when(datasource.fetch).thenAnswer((_) async => entityList);
  });

  test('Should return a list of resources', () async {
    final response = await repository.fetch();
    expect(response.runtimeType, List<ResourceEntity>);
  });

  test('Should call datasource fetch method once', () async {
    await repository.fetch();
    verify(() => datasource.fetch()).called(1);
  });
}
