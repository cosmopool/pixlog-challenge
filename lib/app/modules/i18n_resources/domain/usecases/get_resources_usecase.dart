import 'package:pixlog_challenge/app/modules/i18n_resources/domain/entity/resource_entity.dart';
import 'package:pixlog_challenge/app/modules/i18n_resources/domain/interfaces/resources_repository_interface.dart';

class GetResourcesUsecase {
  final ResourcesRepositoryInterface _repository;

  GetResourcesUsecase(this._repository);

  Future<List<ResourceEntity>> call() async {
    return await _repository();
  }
}
