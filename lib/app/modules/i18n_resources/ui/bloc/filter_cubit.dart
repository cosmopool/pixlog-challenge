import 'package:bloc/bloc.dart';

/// Cubit that controls the FilterWidget visibility
class FilterCubit extends Cubit<bool> {
  FilterCubit() : super(false);

  void toggleVisibility() => emit(!state);
}
