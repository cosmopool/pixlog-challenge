import 'package:pixlog_challenge/app/modules/core/errors.dart';
import 'package:pixlog_challenge/app/modules/core/services/network/network_info.dart';
import 'package:pixlog_challenge/app/modules/i18n_resources/domain/entity/resource_entity.dart';
import 'package:pixlog_challenge/app/modules/i18n_resources/domain/interfaces/resources_repository_interface.dart';
import 'package:pixlog_challenge/app/modules/i18n_resources/infra/interfaces/resources_datasource_interface.dart';

class ResourcesRepository implements IResourcesRepository {
  final IResourcesDatasource _datasource;

  ResourcesRepository(this._datasource);

  @override
  Future<List<ResourceEntity>> fetch() async {
    if (await NetworkInfoService.isConnected) {
      return await _datasource.fetch();
    } else {
      throw NoInternetConnection();
    }
  }
}
