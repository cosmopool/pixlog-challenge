import 'package:pixlog_challenge/app/modules/core/services/http/http_client_interface.dart';
import 'package:pixlog_challenge/app/modules/i18n_resources/domain/entity/resource_entity.dart';
import 'package:pixlog_challenge/app/modules/i18n_resources/external/mappers/resources_mapper.dart';
import 'package:pixlog_challenge/app/modules/i18n_resources/infra/interfaces/resources_datasource_interface.dart';

class RemoteDatasource implements IResourcesDatasource {
  final IHttpClientService _httpClient;
  final url = "http://url";

  RemoteDatasource(this._httpClient);

  @override
  Future<List<ResourceEntity>> fetch() async {
    final response = await _httpClient.get(url);
    final resources = ResourcesMapper.fromList(response.data);
    return resources;
  }
}
