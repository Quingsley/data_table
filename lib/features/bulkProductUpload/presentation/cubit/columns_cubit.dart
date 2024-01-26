import 'package:data_table/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// manages the visibility of the columns in the data table
class ColumnsCubit extends Cubit<List<ProductColumn>> {
  /// [ColumnsCubit] constructor
  ColumnsCubit()
      : super(
          ProductColumnsEnum.values
              .map((e) => ProductColumn(name: e.name))
              .toList(),
        );

  /// [toggleColumn] method that toggles the visibility of the column
  void toggleColumn(ProductColumn newColumn) {
    final newColumnState = [
      for (final column in state)
        column.name == newColumn.name
            ? column.copyWith(isVisible: !column.isVisible)
            : column,
    ];

    emit(newColumnState);
  }
}

/// [ProductColumn] is a class that represents the columns of the DataTable
class ProductColumn extends Equatable {
  /// [ProductColumn] constructor
  const ProductColumn({required this.name, this.isVisible = true});

  /// [name] is the name of the column
  final String name;

  /// [isVisible] is a boolean value that determines if the column is visible
  final bool isVisible;

  /// [copyWith] method that returns a new instance of [ProductColumn]
  ProductColumn copyWith({
    String? name,
    bool? isVisible,
  }) {
    return ProductColumn(
      name: name ?? this.name,
      isVisible: isVisible ?? this.isVisible,
    );
  }

  @override
  List<Object?> get props => [name, isVisible];
}
