import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pixlog_challenge/app/modules/core/services/http/http_client.dart';
import 'package:pixlog_challenge/app/modules/core/services/http/http_client_interface.dart';

import '../../../../stubs/resources_response.dart';

class MockDio extends Mock implements Dio {}

late MockDio dio;
late IHttpClientService client;
const url = "http://test.url";

final dioResponse = Response(
  requestOptions: RequestOptions(path: url),
  data: resourcesResponse,
);

void main() async {
  setUp(() async {
    dio = MockDio();
    client = HttpClientService(dio);
    when(() => dio.get(any())).thenAnswer((_) async => dioResponse);
  });

  test('Should return a list of resources', () async {
    final clientResponse = await client.get(url);
    expect(clientResponse.data, resourcesResponse);
  });

  test('Should call client get method once', () async {
    await client.get(url);
    verify(() => dio.get(any())).called(1);
  });
}
