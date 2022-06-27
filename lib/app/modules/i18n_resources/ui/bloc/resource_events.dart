import 'package:equatable/equatable.dart';

abstract class ResourceEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ResourceFetchedEvent extends ResourceEvent {}

class ResourceFilterEvent extends ResourceEvent {
  final String? languageFilter;
  final String? moduleFilter;
  final String? valueFilter;
  ResourceFilterEvent({
    this.languageFilter,
    this.moduleFilter,
    this.valueFilter,
  });

  @override
  List<Object> get props => [languageFilter ?? "", moduleFilter ?? "", valueFilter ?? ""];
}
