import 'package:equatable/equatable.dart';

/// [ProductCategory] is a class that represents the category of a product
class ProductCategory extends Equatable {
  /// [ProductCategory] constructor
  const ProductCategory({
    required this.id,
    required this.name,
    this.isSelected = false,
    this.subCategories = const [],
  });

  /// category id
  final String id;

  /// category name
  final String name;

  /// whether the category is selected or not
  final bool isSelected;

  /// contains list of sub-categories
  final List<ProductSubCategory> subCategories;

  /// returns a copy of the [ProductCategory] with the
  /// specified fields replaced with the new values
  ProductCategory copyWith({
    String? id,
    String? name,
    bool? isSelected,
    List<ProductSubCategory>? subCategories,
  }) {
    return ProductCategory(
      id: id ?? this.id,
      name: name ?? this.name,
      isSelected: isSelected ?? this.isSelected,
      subCategories: subCategories ?? this.subCategories,
    );
  }

  @override
  List<Object?> get props => [id, name, isSelected];

  @override
  bool? get stringify => true;
}

/// [ProductSubCategory] is a class that represents
/// the sub-category of a product
class ProductSubCategory extends Equatable {
  /// [ProductSubCategory] constructor
  const ProductSubCategory({
    required this.id,
    required this.name,
    this.isSelected = false,
    this.categoryId,
  });

  /// category id
  final String? categoryId;

  /// sub-category id
  final String id;

  /// sub-category name
  final String name;

  /// whether the sub-category is selected or not
  final bool isSelected;

  /// returns a copy of the [ProductSubCategory] with the specified fields
  /// replaced with the new values
  ProductSubCategory copyWith({String? id, String? name, bool? isSelected}) {
    return ProductSubCategory(
      id: id ?? this.id,
      name: name ?? this.name,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  List<Object?> get props =>
      [name]; // only name is used for comparison purposes
}
