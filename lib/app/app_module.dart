import 'package:flutter_modular/flutter_modular.dart';
import 'package:pixlog_challenge/app/modules/i18n_resources/i18n_resources_module.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute("/", module: I18nResoucesModule()),
      ];
}
