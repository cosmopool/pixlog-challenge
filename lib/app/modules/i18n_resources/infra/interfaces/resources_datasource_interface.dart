import 'package:pixlog_challenge/app/modules/i18n_resources/domain/entity/resource_entity.dart';

abstract class IResourcesDatasource {
  Future<List<ResourceEntity>> fetch();
}
