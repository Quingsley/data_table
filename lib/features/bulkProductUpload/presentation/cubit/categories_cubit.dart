import 'package:data_table/features/bulkProductUpload/data/models/product_category_model.dart';
import 'package:data_table/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

/// manages the state of the categories in the header filters
class CategoriesCubit extends Cubit<List<ProductCategory>> {
  /// [CategoriesCubit] constructor

  CategoriesCubit() : super(_data);

  /// toggles the selection of a sub-category
  void toggleSubCategories(ProductSubCategory subCategory) {
    final newCategories = state.map((category) {
      final newSubCategories = category.subCategories.map((sub) {
        if (sub.id == subCategory.id) {
          return sub.copyWith(isSelected: !sub.isSelected);
        }
        return sub;
      }).toList();
      return category.copyWith(subCategories: newSubCategories);
    }).toList();
    emit(newCategories);
  }
}

/// instance of [Uuid] to generate unique ids
Uuid uuid = const Uuid();

List<ProductCategory> _data = [
  ProductCategory(
    name: ProductCategoryEnum.food.name,
    id: uuid.v4(),
    subCategories: [
      ProductSubCategory(
        id: uuid.v4(),
        name: ProductSubCategoryEnum.flour.name,
      ),
      ProductSubCategory(
        id: uuid.v4(),
        name: ProductSubCategoryEnum.oil.name,
      ),
      ProductSubCategory(
        id: uuid.v4(),
        name: ProductSubCategoryEnum.salt.name,
      ),
      ProductSubCategory(
        id: uuid.v4(),
        name: ProductSubCategoryEnum.snacks.name,
      ),
      ProductSubCategory(
        id: uuid.v4(),
        name: ProductSubCategoryEnum.sugar.name,
      ),
    ],
  ),
  ProductCategory(
    id: uuid.v4(),
    name: ProductCategoryEnum.drinks.name,
    subCategories: [
      ProductSubCategory(
        id: uuid.v4(),
        name: ProductSubCategoryEnum.water.name,
      ),
      ProductSubCategory(
        id: uuid.v4(),
        name: ProductSubCategoryEnum.beverages.name,
      ),
    ],
  ),
  ProductCategory(
    id: uuid.v4(),
    name: ProductCategoryEnum.cutlery.name,
    subCategories: [
      ProductSubCategory(
        id: uuid.v4(),
        name: ProductSubCategoryEnum.spoons.name,
      ),
    ],
  ),
];
