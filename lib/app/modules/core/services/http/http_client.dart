import 'package:dio/dio.dart';
import 'package:pixlog_challenge/app/modules/core/services/http/http_client_interface.dart';
import 'package:pixlog_challenge/app/modules/core/services/models/http_response.dart';

class HttpClientService implements IHttpClientService {
  final Dio _client;

  HttpClientService(this._client);

  @override
  Future<HttpResponse> get(String url) async {
    final response = await _client.get(url);
    return HttpResponse(
      data: response.data,
      statusCode: response.statusCode ?? 0,
    );
  }
}
