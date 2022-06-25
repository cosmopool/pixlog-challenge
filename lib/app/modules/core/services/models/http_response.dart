class HttpResponse {
  final int statusCode;
  final dynamic data;

  HttpResponse({
    this.statusCode = 0,
    required this.data,
  });
}
