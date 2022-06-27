import 'package:pixlog_challenge/app/modules/core/extensions/datetime_extension.dart';
import 'package:pixlog_challenge/app/modules/i18n_resources/domain/entity/resource_entity.dart';

class ResourcesMapper {
  /// Returns a list of ResourceEntity given a json list
  static fromList(List list) {
    List<ResourceEntity> finalList = [];
    for (var map in list) {
      final resourceMap = map['resource'];

      final String createdAt =
          resourceMap['created_at'] ?? "1900-01-01T00:00:00Z";
      final String updatedAt =
          resourceMap['updated_at'] ?? "1900-01-01T00:00:00Z";

      final resource = ResourceEntity(
        createdAt: DateTime.parse(createdAt),
        updatedAt: DateTime.parse(updatedAt),
        resourceId: resourceMap['resource_id'],
        moduleId: resourceMap['module_id'],
        value: resourceMap['value'],
        languageId: resourceMap['language_id'],
      );

      finalList.add(resource);
    }

    return finalList;
  }

  /// Returns a map given a ResourceEntity
  static toMap(ResourceEntity entity) => {
        "resource": {
          "created_at": entity.createdAt.toResouceFormatString,
          "updated_at": entity.updatedAt.toResouceFormatString,
          "resource_id": entity.resourceId,
          "module_id": entity.moduleId,
          "value": entity.value,
          "language_id": entity.languageId,
        }
      };

  /// Returns a list of maps given a list of ResourceEntity
  static toMapList(List<ResourceEntity> list) {
    List<Map> mapList = [];
    for (var entity in list) {
      final map = toMap(entity);
      mapList.add(map);
    }
    return mapList;
  }
}
