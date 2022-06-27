import 'package:bloc/bloc.dart';
import 'package:pixlog_challenge/app/modules/i18n_resources/domain/entity/resource_entity.dart';
import 'package:pixlog_challenge/app/modules/i18n_resources/domain/usecases/get_resources_usecase.dart';
import 'package:pixlog_challenge/app/modules/i18n_resources/ui/bloc/resource_events.dart';
import 'package:pixlog_challenge/app/modules/i18n_resources/ui/bloc/resource_state.dart';

class ResourceBloc extends Bloc<ResourceEvent, ResourceState> {
  final GetResourcesUsecase _fetchUsecase;

  ResourceBloc(this._fetchUsecase) : super(const ResourceState()) {
    on<ResourceFetchedEvent>(_onPostFetched);
    on<ResourceFilterEvent>(_filterResources);
  }

  bool _isInvalidString(String? string) => (string == null || string.isEmpty);

  void _filterResources(
    ResourceFilterEvent event,
    Emitter<ResourceState> emit,
  ) {
    final cache = state.cache;
    final languageFilter = event.languageFilter;
    final moduleFilter = event.moduleFilter;
    final valueFilter = event.valueFilter;

    // filter all entities by languageId only if languageFilter is not empty
    final byLanguage = _isInvalidString(languageFilter)
        ? cache
        : cache.where((e) => e.languageId == languageFilter).toList();

    // filter by moduleId entities already filtered by languageId only if moduleFilter is not empty
    final byModule = _isInvalidString(moduleFilter)
        ? byLanguage
        : byLanguage.where((e) => e.moduleId == moduleFilter).toList();

    // filter by value entities already filtered by languageId and moduleId only if valueFilter is not empty
    final byValue = _isInvalidString(valueFilter)
        ? byModule
        : byModule.where((e) => e.value.contains(valueFilter!)).toList();

    final filteredList = byValue;

    emit(state.copyWith(
      status: ResourceStatus.success,
      resources: filteredList,
    ));
  }

  List<String> _getLanguages(List<ResourceEntity> resources) {
    List<String> list = [];

    for (var resource in resources) {
      final language = resource.languageId;
      if (!list.contains(language)) list.add(language);
    }

    return list;
  }

  List<String> _getModules(List<ResourceEntity> resources) {
    List<String> list = [];

    for (var resource in resources) {
      final module = resource.moduleId;
      if (!list.contains(module)) list.add(module);
    }

    return list;
  }

  void _onPostFetched(
    ResourceFetchedEvent event,
    Emitter<ResourceState> emit,
  ) async {
    try {
      final resources = await _fetchUsecase();
      final languages = _getLanguages(resources);
      final modules = _getModules(resources);
      return emit(
        state.copyWith(
          status: ResourceStatus.success,
          resources: resources,
          cache: resources,
          languages: languages,
          modules: modules,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: ResourceStatus.failure));
    }
  }
}
