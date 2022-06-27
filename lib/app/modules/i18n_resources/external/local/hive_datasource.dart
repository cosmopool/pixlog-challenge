import 'package:hive/hive.dart';
import 'package:pixlog_challenge/app/modules/i18n_resources/domain/entity/resource_entity.dart';
import 'package:pixlog_challenge/app/modules/i18n_resources/external/mappers/resources_mapper.dart';
import 'package:pixlog_challenge/app/modules/i18n_resources/infra/interfaces/resources_datasource_interface.dart';

class HiveDatasource implements IResourcesDatasource {
  final Box _box;
  HiveDatasource(this._box);

  Future<void> save(List<Map> resources) async {
    await _box.put("resources", resources);
  }

  @override
  Future<List<ResourceEntity>> fetch() async {
    final response = _box.get("resources", defaultValue: <Map>[]);
    final resources = ResourcesMapper.fromList(response);
    return resources;
  }
}
