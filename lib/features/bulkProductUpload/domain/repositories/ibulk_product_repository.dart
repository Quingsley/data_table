import 'package:data_table/features/bulkProductUpload/data/models/bulk_product_model.dart';

abstract class IBulkProductRepository {
  Future<List<BulkProductModel>> getProducts();
}
