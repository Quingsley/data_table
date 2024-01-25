import 'package:data_table/features/bulkProductUpload/data/models/bulk_product_model.dart';

/// [IBulkProductRepository] is an interface
abstract class IBulkProductRepository {
  /// [getProducts] method that returns a [Future] of list of [BulkProductModel]
  Future<List<BulkProductModel>> getProducts();
}
