import 'package:pixlog_challenge/app/modules/core/services/models/http_response.dart';

abstract class IHttpClientService {
  Future<HttpResponse> get(String url);
}
