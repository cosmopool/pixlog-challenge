import 'package:pixlog_challenge/app/modules/i18n_resources/ui/bloc/filter_cubit.dart';
import 'package:test/test.dart';

late FilterCubit cubit;

void main() async {
  setUp(() async {
    cubit = FilterCubit();
  });

  test('Should have initial state = false', () {
    expect(cubit.state, false);
  });

  test('Should toggle state to true', () {
    cubit.toggleVisibility();
    expect(cubit.state, true);
  });
}
