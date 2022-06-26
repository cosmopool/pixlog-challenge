import 'package:flutter_modular/flutter_modular.dart';
import 'package:pixlog_challenge/app/modules/core/core_module.dart';
import 'package:pixlog_challenge/app/modules/i18n_resources/domain/usecases/get_resources_usecase.dart';
import 'package:pixlog_challenge/app/modules/i18n_resources/external/remote_datasource.dart';
import 'package:pixlog_challenge/app/modules/i18n_resources/infra/repositories/resources_repository.dart';
import 'package:pixlog_challenge/app/modules/i18n_resources/ui/bloc/resource_bloc.dart';
import 'package:pixlog_challenge/app/modules/i18n_resources/ui/pages/home_page.dart';

class I18nResoucesModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  List<Bind> get binds => [
        // datasources
        Bind.lazySingleton((i) => RemoteDatasource(i())),
        // repositories
        Bind.lazySingleton((i) => ResourcesRepository(i())),
        // usecases
        Bind.lazySingleton((i) => GetResourcesUsecase(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => HomePage()),
      ];
}
