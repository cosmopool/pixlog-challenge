import 'package:equatable/equatable.dart';

abstract class ResourceEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ResourceFetchedEvent extends ResourceEvent {}

class ResourceFilterEvent extends ResourceEvent {
  final String? languageFilter;
  final String? moduleFilter;
  ResourceFilterEvent({
    this.languageFilter,
    this.moduleFilter,
  });

  @override
  List<Object> get props => [languageFilter ?? "", moduleFilter ?? ""];
}
