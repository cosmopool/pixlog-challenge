import 'package:dio/dio.dart';
import 'package:logging/logging.dart';
import 'package:pixlog_challenge/app/modules/core/services/http/http_client_interface.dart';
import 'package:pixlog_challenge/app/modules/core/services/models/http_response.dart';

class HttpClientService implements IHttpClientService {
  final Dio _client;
  final log = Logger('HttpClientService');

  HttpClientService(this._client);

  @override
  Future<HttpResponse> get(String url) async {

    log.info("[HTTP] fetching data...");
    final response = await _client.get(url);
    log.info("[HTTP] finished! response status: ${response.statusCode}");
    return HttpResponse(
      data: response.data,
      statusCode: response.statusCode ?? 0,
    );
  }
}
