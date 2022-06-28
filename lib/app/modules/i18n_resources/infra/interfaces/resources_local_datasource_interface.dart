import 'package:pixlog_challenge/app/modules/i18n_resources/domain/entity/resource_entity.dart';

abstract class IResourcesLocalDatasource {
  Future<void> save(List<Map> resources);
  Future<List<ResourceEntity>> fetch();
}
