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
