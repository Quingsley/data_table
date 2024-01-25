import 'package:data_table/features/bulkProductUpload/data/models/bulk_product_model.dart';
import 'package:data_table/features/bulkProductUpload/data/repositories/bulk_product_repository_impl.dart';

/// [BulkProductUseCase] is a use case that returns a list of [BulkProductModel]
class BulkProductUseCase {
  /// [BulkProductUseCase] constructor
  BulkProductUseCase({required this.repository});

  /// [BulkProductRepositoryImpl] repository
  final BulkProductRepositoryImpl repository;

  /// [call] method that returns a [Future] of list of [BulkProductModel]
  Future<List<BulkProductModel>> call() async {
    return repository.getProducts();
  }
}
