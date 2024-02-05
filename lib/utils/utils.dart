import 'package:data_table/features/bulkProductUpload/data/models/bulk_product_model.dart';
import 'package:pluto_grid/pluto_grid.dart';

/// utility class
class Utils {
  /// [modelBuilder] method that returns a list of [T]
  /// from a list of [M] and a builder function
  static List<T> modelBuilder<M, T>(
    List<M> models,
    T Function(int index, M model) builder,
  ) =>
      models
          .asMap()
          .map<int, T>((index, model) => MapEntry(index, builder(index, model)))
          .values
          .toList();
}

/// [ProductColumnsEnum] enum
enum ProductColumnsEnum {
  /// product Name column
  productName,

  /// quantity column
  quantity,

  /// buying price column
  buyingPrice,

  /// selling price column
  sellingPrice,
}

/// [getColumnName] method that returns the human readable column name
String getColumnName(String column) {
  switch (column) {
    case 'buyingPrice':
      return 'Buying Price';
    case 'quantity':
      return 'Quantity';
    case 'sellingPrice':
      return 'Selling Price';
    case 'productName':
      return 'Product Name';
    default:
      return '';
  }
}

/// [ProductCategoryEnum] enum
enum ProductCategoryEnum {
  /// food category
  food,

  /// drinks category
  drinks,

  /// cutlery category
  cutlery,
}

/// [ProductSubCategoryEnum] enum
enum ProductSubCategoryEnum {
  /// flour sub-category
  flour,

  /// sugar sub-category
  sugar,

  /// oil sub-category
  oil,

  /// spoons sub-category
  spoons,

  /// water sub-category
  water,

  /// snacks sub-category
  snacks,

  /// beverages sub-category
  beverages,

  /// salt sub-category
  salt,
}

final List<PlutoColumn> uiColumns = <PlutoColumn>[
  PlutoColumn(
    title: 'Product Name',
    field: 'productName',
    enableContextMenu: false,
    enableRowChecked: true,
    enableColumnDrag: false,
    type: PlutoColumnType.text(),
  ),
  PlutoColumn(
    title: 'Quantity',
    field: 'quantity',
    width: 120,
    enableDropToResize: false,
    enableColumnDrag: false,
    enableContextMenu: false,
    type: PlutoColumnType.number(
      negative: false,
    ),
  ),
  PlutoColumn(
    title: 'BuyingPrice',
    field: 'buyingPrice',
    enableColumnDrag: false,
    enableDropToResize: false,
    enableContextMenu: false,
    width: 120,
    type: PlutoColumnType.number(
      negative: false,
    ),
  ),
  PlutoColumn(
    title: 'Selling Price',
    field: 'sellingPrice',
    enableContextMenu: false,
    enableDropToResize: false,
    width: 120,
    enableColumnDrag: false,
    type: PlutoColumnType.number(
      negative: false,
    ),
  ),
];

/// [addProductsToRow] method that returns a [PlutoRow] of the new product
PlutoRow addProductsToRow(BulkProductModel product) {
  return PlutoRow(
    checked: product.isSelected,
    cells: {
      'id': PlutoCell(value: product.id),
      'productName': PlutoCell(value: product.productName),
      'quantity': PlutoCell(value: product.quantity),
      'buyingPrice': PlutoCell(value: product.buyingPrice),
      'sellingPrice': PlutoCell(value: product.sellingPrice),
    },
  );
}
