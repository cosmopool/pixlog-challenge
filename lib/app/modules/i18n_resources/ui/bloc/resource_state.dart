import 'package:equatable/equatable.dart';
import 'package:pixlog_challenge/app/modules/i18n_resources/domain/entity/resource_entity.dart';

enum ResourceStatus { initial, success, failure }

class ResourceState extends Equatable {
  final ResourceStatus status;
  final List<ResourceEntity> resources;

  const ResourceState({
    this.status = ResourceStatus.initial,
    this.resources = const <ResourceEntity>[],
  });

  ResourceState copyWith({
    ResourceStatus? status,
    List<ResourceEntity>? resources,
  }) {
    return ResourceState(
      status: status ?? this.status,
      resources: resources ?? this.resources,
    );
  }

  @override
  String toString() {
    return '''ResourceState { status: $status, resources: ${resources.length} }''';
  }

  @override
  List<Object> get props => [status, resources];
}
