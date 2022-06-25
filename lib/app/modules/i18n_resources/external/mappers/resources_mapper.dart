import 'package:pixlog_challenge/app/modules/i18n_resources/domain/entity/resource_entity.dart';

class ResourcesMapper {
  static fromList(List<Map> list) {
    List<ResourceEntity> finalList = [];
    for (var map in list) {
      final resourceMap = map['resource'];

      final String createdAt = resourceMap['created_at'];
      final String updatedAt = resourceMap['updated_at'];

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
}
