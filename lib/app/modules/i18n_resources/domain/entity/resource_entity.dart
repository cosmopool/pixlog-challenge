import 'package:equatable/equatable.dart';

class ResourceEntity extends Equatable {
  final DateTime createdAt;
  final DateTime updatedAt;
  final String resourceId;
  final String moduleId;
  final String value;
  final String languageId;

  const ResourceEntity({
    required this.createdAt,
    required this.updatedAt,
    required this.resourceId,
    required this.moduleId,
    required this.value,
    required this.languageId,
  });

  @override
  List<Object?> get props => [createdAt, updatedAt, resourceId, moduleId, value, languageId];
}
