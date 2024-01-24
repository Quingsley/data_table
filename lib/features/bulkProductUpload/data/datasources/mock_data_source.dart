import 'package:data_table/features/bulkProductUpload/data/models/bulk_product_model.dart';

abstract class MockDataSource {
  Future<List<BulkProductModel>> getProducts();
}

class MockDataSourceImpl implements MockDataSource {
  @override
  Future<List<BulkProductModel>> getProducts() async {
    await Future.delayed(const Duration(seconds: 2));
    return _data;
  }
}

List<BulkProductModel> _data = [
  const BulkProductModel(
      productName: 'Mumias Sugar',
      quantity: 250,
      buyingPrice: 210,
      sellingPrice: 205),
  const BulkProductModel(
      productName: 'Jogoo Flour',
      quantity: 250,
      buyingPrice: 210,
      sellingPrice: 205),
  const BulkProductModel(
      productName: 'Ndovu Flour',
      quantity: 250,
      buyingPrice: 210,
      sellingPrice: 205),
  const BulkProductModel(
      productName: 'KEN Salt',
      quantity: 250,
      buyingPrice: 210,
      sellingPrice: 205),
  const BulkProductModel(
      productName: 'Kabras Sugar',
      quantity: 250,
      buyingPrice: 210,
      sellingPrice: 205),
  const BulkProductModel(
      productName: 'Ajab flour',
      quantity: 250,
      buyingPrice: 210,
      sellingPrice: 205),
  const BulkProductModel(
      productName: 'Rina Cooking oil',
      quantity: 250,
      buyingPrice: 210,
      sellingPrice: 205),
];
