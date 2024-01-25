import 'package:data_table/features/bulkProductUpload/data/datasources/mock_data_source.dart';
import 'package:data_table/features/bulkProductUpload/data/models/bulk_product_model.dart';
import 'package:data_table/features/bulkProductUpload/domain/repositories/ibulk_product_repository.dart';

/// concrete implementation of [IBulkProductRepository]
class BulkProductRepositoryImpl implements IBulkProductRepository {
  /// [BulkProductRepositoryImpl] constructor
  BulkProductRepositoryImpl({required this.mockDataSource});

  /// to swap with the real data source
  final MockDataSource mockDataSource;

  @override
  Future<List<BulkProductModel>> getProducts() {
    return mockDataSource.getProducts();
  }
}
