import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_test/hive_test.dart';
import 'package:pixlog_challenge/app/modules/core/services/http/http_client_interface.dart';
import 'package:pixlog_challenge/app/modules/i18n_resources/external/local/hive_datasource.dart';

import '../../../../../stubs/resources_response.dart';

void main() async {
  late Box box;
  late HiveDatasource cache;
  late IHttpClientService httpClient;

  setUp(() async {
    await setUpTestHive();
    box = await Hive.openBox<List<Map>>('testBox');
    cache = HiveDatasource(box);
  });

  test('Should return a empty list on empty cache', () async {
    final result = await cache.fetch();
    expect(result, []);
  });

  test('Should save resouce list', () async {
    await cache.save(resourcesResponse);
    expect(box.get("resources").length, resourcesResponse.length);
  });

  test('Should return a list of resources', () async {
    await cache.save(resourcesResponse);
    final result = await cache.fetch();
    expect(result.length, resourcesResponse.length);
  });

  test('Should overwrite any cached list', () async {
    // arrange
    await cache.save(resourcesResponse);
    expect(box.get("resources").length, 12);
    await cache.save([]);
    // act
    final result = await cache.fetch();
    // assert
    expect(result, []);
  });
}
