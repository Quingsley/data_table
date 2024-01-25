import 'package:data_table/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// manages the visibility of the columns in the data table
class ColumnsCubit extends Cubit<List<Column>> {
  /// [ColumnsCubit] constructor
  ColumnsCubit()
      : super(ProductColumns.values.map((e) => Column(name: e.name)).toList());

  /// [toggleColumn] method that toggles the visibility of the column
  void toggleColumn(Column newColumn) {
    for (final column in state) {
      if (column.name == newColumn.name) {
        column.copyWith(isVisible: !column.isVisible);
      }
    }
  }
}

/// [Column] is a class that represents the columns of the DataTable
class Column extends Equatable {
  /// [Column] constructor
  const Column({required this.name, this.isVisible = false});

  /// [name] is the name of the column
  final String name;

  /// [isVisible] is a boolean value that determines if the column is visible
  final bool isVisible;

  /// [copyWith] method that returns a new instance of [Column]
  Column copyWith({
    String? name,
    bool? isVisible,
  }) {
    return Column(
      name: name ?? this.name,
      isVisible: isVisible ?? this.isVisible,
    );
  }

  @override
  List<Object?> get props => [name, isVisible];
}
