import 'package:flutter_bloc/flutter_bloc.dart';

/// [IsAscendingCubit] is a [Cubit] that manages the isAscending state
class IsAscendingCubit extends Cubit<bool> {
  /// [IsAscendingCubit] constructor
  IsAscendingCubit() : super(false);

  /// toggles the isAscending state
  void toggle() {
    emit(!state);
  }
}

/// [CheckBoxSelectionCubit] is a [Cubit] that manages the showing of the
///  checkbox column in the data table
class CheckBoxSelectionCubit extends Cubit<bool> {
  /// [CheckBoxSelectionCubit] constructor
  CheckBoxSelectionCubit() : super(true);

  /// toggles the checkbox column
  void toggle() {
    emit(!state);
  }
}
