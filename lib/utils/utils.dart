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

/// [ProductColumns] enum
enum ProductColumns {
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
String getColumnName(ProductColumns column) {
  switch (column) {
    case ProductColumns.buyingPrice:
      return 'Buying Price';
    case ProductColumns.quantity:
      return 'Quantity';
    case ProductColumns.sellingPrice:
      return 'Selling Price';
    case ProductColumns.productName:
      return 'Product Name';
  }
}
