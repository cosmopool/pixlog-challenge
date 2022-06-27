import 'package:bloc/bloc.dart';
import 'package:pixlog_challenge/app/modules/i18n_resources/ui/bloc/dropdown_state.dart';

/// Cubit that controls the language dropdownButton value
class DropdownValueCubit extends Cubit<DropdownState> {
  DropdownValueCubit() : super(const DropdownState(language: "", module: ""));

  void cleanFilters() => emit(const DropdownState(language: "", module: ""));

  void filterBy({String? language, String? module}) {
    emit(
      state.copyWith(
        module: module,
        language: language,
      ),
    );
  }
}
