import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pixlog_challenge/app/modules/core/services/http/http_client_interface.dart';
import 'package:pixlog_challenge/app/modules/core/services/models/http_response.dart';
import 'package:pixlog_challenge/app/modules/i18n_resources/domain/entity/resource_entity.dart';
import 'package:pixlog_challenge/app/modules/i18n_resources/external/remote/remote_datasource.dart';
import 'package:pixlog_challenge/app/modules/i18n_resources/infra/interfaces/resources_datasource_interface.dart';

import '../../../../../stubs/resources_response.dart';


class MockHttpClient extends Mock implements IHttpClientService {}

late IResourcesDatasource datasource;
late IHttpClientService httpClient;

final httpResponse = HttpResponse(statusCode: 200, data: resourcesResponse);
const url = "http://url.test";

void main() async {
  setUp(() async {
    httpClient = MockHttpClient();
    datasource = RemoteDatasource(httpClient, url);
    when(() => httpClient.get(any())).thenAnswer((_) async => httpResponse);
  });

  test('Should return a list of resources', () async {
    final response = await datasource.fetch();
    expect(response.runtimeType, List<ResourceEntity>);
  });

  test('Should call client get method once', () async {
    await datasource.fetch();
    verify(() => httpClient.get(any())).called(1);
  });
}
