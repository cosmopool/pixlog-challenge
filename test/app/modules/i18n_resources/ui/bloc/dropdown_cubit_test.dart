import 'package:pixlog_challenge/app/modules/i18n_resources/ui/bloc/dropdown_cubit.dart';
import 'package:pixlog_challenge/app/modules/i18n_resources/ui/bloc/dropdown_state.dart';
import 'package:test/test.dart';

late DropdownValueCubit cubit;

void main() async {
  setUp(() async {
    cubit = DropdownValueCubit();
  });

  test('Should have empty language initial state', () {
    const state = DropdownState(language: "", module: "");
    expect(cubit.state.language, state.language);
  });

  test('Should have empty module initial state', () {
    const state = DropdownState(language: "", module: "");
    expect(cubit.state.module, state.module);
  });

  test('Should have language state = "en"', () {
    cubit.filterBy(language: "en");
    expect(cubit.state.language, "en");
  });

  test('Should have module state = "Module"', () {
    cubit.filterBy(module: "Module");
    expect(cubit.state.module, "Module");
  });

  test('Should have empty module state when set only language', () {
    cubit.filterBy(language: "en");
    expect(cubit.state.module, "");
  });

  test('Should have empty language state when set only module', () {
    cubit.filterBy(module: "Module");
    expect(cubit.state.language, "");
  });

  test('Should return to empty state', () {
    cubit.filterBy(language: "en");
    cubit.cleanFilters();
    const state = DropdownState(language: "", module: "");
    expect(cubit.state, state);
  });
}
