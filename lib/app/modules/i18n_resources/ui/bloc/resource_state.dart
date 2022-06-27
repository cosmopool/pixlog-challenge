import 'package:equatable/equatable.dart';
import 'package:pixlog_challenge/app/modules/i18n_resources/domain/entity/resource_entity.dart';

enum ResourceStatus { initial, success, failure, loading }

class ResourceState extends Equatable {
  final ResourceStatus status;
  final List<ResourceEntity> resources;
  final List<ResourceEntity> cache;
  final List<String> languages;
  final List<String> modules;
  final String error;

  const ResourceState({
    this.status = ResourceStatus.initial,
    this.resources = const <ResourceEntity>[],
    this.cache = const <ResourceEntity>[],
    this.languages = const <String>[],
    this.modules = const <String>[],
    this.error = "",
  });

  ResourceState copyWith({
    ResourceStatus? status,
    List<ResourceEntity>? resources,
    List<ResourceEntity>? cache,
    List<String>? languages,
    List<String>? modules,
    String? error,
  }) {
    return ResourceState(
      status: status ?? this.status,
      resources: resources ?? this.resources,
      cache: cache ?? this.cache,
      languages: languages ?? this.languages,
      modules: modules ?? this.modules,
      error: error ?? this.error,
    );
  }

  @override
  String toString() {
    return '''ResourceState { status: $status, resources: ${resources.length} }''';
  }

  @override
  List<Object> get props => [status, resources, cache, languages, modules, error];
}
