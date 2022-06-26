import 'package:equatable/equatable.dart';

abstract class ResourceEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ResourceFetchedEvent extends ResourceEvent {}
