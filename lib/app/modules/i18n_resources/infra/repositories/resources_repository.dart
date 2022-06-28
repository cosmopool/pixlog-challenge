import 'package:logging/logging.dart';
import 'package:pixlog_challenge/app/modules/core/errors.dart';
import 'package:pixlog_challenge/app/modules/core/services/network/network_info.dart';
import 'package:pixlog_challenge/app/modules/i18n_resources/domain/entity/resource_entity.dart';
import 'package:pixlog_challenge/app/modules/i18n_resources/domain/interfaces/resources_repository_interface.dart';
import 'package:pixlog_challenge/app/modules/i18n_resources/external/mappers/resources_mapper.dart';
import 'package:pixlog_challenge/app/modules/i18n_resources/infra/interfaces/resources_datasource_interface.dart';
import 'package:pixlog_challenge/app/modules/i18n_resources/infra/interfaces/resources_local_datasource_interface.dart';

class ResourcesRepository implements IResourcesRepository {
  final IResourcesDatasource _api;
  final IResourcesLocalDatasource _cache;
  final log = Logger('HttpClientService');

  ResourcesRepository(this._api, this._cache);

  @override
  Future<List<ResourceEntity>> fetch() async {
    if (await NetworkInfoService.isConnected) {
      final result = await _api.fetch();
      await _cache.save(ResourcesMapper.toMapList(result));
      return result;
    } else {
      log.info("[REPO] no connection with internet, going for cache...");
      final cacheList = await _cache.fetch();
      if (cacheList.isEmpty) throw NoInternetConnection();
      return cacheList;
    }
  }
}
