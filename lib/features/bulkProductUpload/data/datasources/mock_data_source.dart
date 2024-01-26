import 'package:data_table/features/bulkProductUpload/data/models/bulk_product_model.dart';
import 'package:data_table/features/bulkProductUpload/data/models/product_category_model.dart';
import 'package:data_table/utils/utils.dart';
import 'package:uuid/uuid.dart';

/// instance of [Uuid] to generate unique ids
Uuid uuid = const Uuid();

/// [MockDataSource] is a fake data source that
/// returns a list of [BulkProductModel]
sealed class MockDataSource {
  /// returns a list of [BulkProductModel]
  Future<List<BulkProductModel>> getProducts();
}

/// concrete implementation of [MockDataSource]
class MockDataSourceImpl implements MockDataSource {
  @override
  Future<List<BulkProductModel>> getProducts() async {
    return Future.delayed(const Duration(seconds: 2), () async {
      return _data;
    });
  }
}

List<BulkProductModel> _data = [
  BulkProductModel(
    productName: 'Mumias Sugar',
    quantity: 200,
    buyingPrice: 180,
    sellingPrice: 175,
    id: uuid.v4(),
    category: ProductCategory(
      id: uuid.v4(),
      name: ProductCategoryEnum.food.name,
      subCategories: [
        ProductSubCategory(
          id: uuid.v4(),
          name: ProductSubCategoryEnum.sugar.name,
        ),
      ],
    ),
  ),
  BulkProductModel(
    id: uuid.v4(),
    productName: 'Jogoo Flour',
    quantity: 300,
    buyingPrice: 200,
    sellingPrice: 195,
    category: ProductCategory(
      id: uuid.v4(),
      name: ProductCategoryEnum.food.name,
      subCategories: [
        ProductSubCategory(
          id: uuid.v4(),
          name: ProductSubCategoryEnum.flour.name,
        ),
      ],
    ),
  ),
  BulkProductModel(
    productName: 'Ndovu Flour',
    quantity: 180,
    buyingPrice: 190,
    sellingPrice: 185,
    id: uuid.v4(),
    category: ProductCategory(
      id: uuid.v4(),
      name: ProductCategoryEnum.food.name,
      subCategories: [
        ProductSubCategory(
          id: uuid.v4(),
          name: ProductSubCategoryEnum.flour.name,
        ),
      ],
    ),
  ),
  BulkProductModel(
    productName: 'KEN Salt',
    quantity: 280,
    buyingPrice: 150,
    sellingPrice: 145,
    id: uuid.v4(),
    category: ProductCategory(
      id: uuid.v4(),
      name: ProductCategoryEnum.food.name,
      subCategories: [
        ProductSubCategory(
          id: uuid.v4(),
          name: ProductSubCategoryEnum.salt.name,
        ),
      ],
    ),
  ),
  BulkProductModel(
    productName: 'Kabras Sugar',
    quantity: 220,
    buyingPrice: 220,
    sellingPrice: 215,
    id: uuid.v4(),
    category: ProductCategory(
      id: uuid.v4(),
      name: ProductCategoryEnum.food.name,
      subCategories: [
        ProductSubCategory(
          id: uuid.v4(),
          name: ProductSubCategoryEnum.sugar.name,
        ),
      ],
    ),
  ),
  BulkProductModel(
    productName: 'Ajab flour',
    quantity: 260,
    buyingPrice: 205,
    sellingPrice: 200,
    id: uuid.v4(),
    category: ProductCategory(
      id: uuid.v4(),
      name: ProductCategoryEnum.food.name,
      subCategories: [
        ProductSubCategory(
          id: uuid.v4(),
          name: ProductSubCategoryEnum.flour.name,
        ),
      ],
    ),
  ),
  BulkProductModel(
    productName: 'Rina Cooking oil',
    quantity: 210,
    buyingPrice: 240,
    sellingPrice: 235,
    id: uuid.v4(),
    category: ProductCategory(
      id: uuid.v4(),
      name: ProductCategoryEnum.food.name,
      subCategories: [
        ProductSubCategory(
          id: uuid.v4(),
          name: ProductSubCategoryEnum.oil.name,
        ),
      ],
    ),
  ),
  BulkProductModel(
    productName: 'Premium Coffee Beans',
    quantity: 100,
    buyingPrice: 350,
    sellingPrice: 400,
    id: uuid.v4(),
    category: ProductCategory(
      id: uuid.v4(),
      name: ProductCategoryEnum.food.name,
      subCategories: [
        ProductSubCategory(
          id: uuid.v4(),
          name: ProductSubCategoryEnum.beverages.name,
        ),
      ],
    ),
  ),
  BulkProductModel(
    productName: 'Golden Tea Leaves',
    quantity: 200,
    buyingPrice: 180,
    sellingPrice: 200,
    id: uuid.v4(),
    category: ProductCategory(
      id: uuid.v4(),
      name: ProductCategoryEnum.food.name,
      subCategories: [
        ProductSubCategory(
          id: uuid.v4(),
          name: ProductSubCategoryEnum.beverages.name,
        ),
      ],
    ),
  ),
  BulkProductModel(
    productName: 'Sparkling Water',
    quantity: 150,
    buyingPrice: 120,
    sellingPrice: 130,
    id: uuid.v4(),
    category: ProductCategory(
      id: uuid.v4(),
      name: ProductCategoryEnum.drinks.name,
      subCategories: [
        ProductSubCategory(
          id: uuid.v4(),
          name: ProductSubCategoryEnum.water.name,
        ),
      ],
    ),
  ),
  BulkProductModel(
    productName: 'Exclusive Chocolate Bars',
    quantity: 180,
    buyingPrice: 250,
    sellingPrice: 280,
    id: uuid.v4(),
    category: ProductCategory(
      id: uuid.v4(),
      name: ProductCategoryEnum.food.name,
      subCategories: [
        ProductSubCategory(
          id: uuid.v4(),
          name: ProductSubCategoryEnum.snacks.name,
        ),
      ],
    ),
  ),
];
