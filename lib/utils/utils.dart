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
