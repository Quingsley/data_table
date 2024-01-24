import 'package:data_table/features/bulkProductUpload/data/models/bulk_product_model.dart';
import 'package:data_table/features/bulkProductUpload/data/repositories/bulk_product_repository_impl.dart';

class BulkProductUseCase {
  final BulkProductRepositoryImpl repository;

  BulkProductUseCase({required this.repository});

  Future<List<BulkProductModel>> call() async {
    return await repository.getProducts();
  }
}
