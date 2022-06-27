import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pixlog_challenge/app/modules/core/services/http/http_client.dart';
import 'package:pixlog_challenge/app/modules/core/services/network/network_info.dart';

class CoreModule extends Module {
  final url = "http://portal.greenmilesoftware.com/get_resources_since";

  @override
  List<Bind> get binds => [
        Bind.lazySingleton((i) => Dio(), export: true),
        Bind.lazySingleton((i) => HttpClientService(i()), export: true),
        Bind.lazySingleton((i) => NetworkInfoService(), export: true),
      ];
}
