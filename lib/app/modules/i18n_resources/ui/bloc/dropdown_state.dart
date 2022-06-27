import 'package:equatable/equatable.dart';

class DropdownState extends Equatable {
  final String language;
  final String module;

  const DropdownState({
    this.language = "",
    this.module = "",
  });

  DropdownState copyWith({
    String? language,
    String? module,
  }) {
    return DropdownState(
      module: module ?? this.module,
      language: language ?? this.language,
    );
  }

  @override
  List<Object?> get props => [language, module];
}
