import 'package:data_table/features/bulkProductUpload/data/datasources/mock_data_source.dart';
import 'package:data_table/features/bulkProductUpload/data/models/bulk_product_model.dart';
import 'package:data_table/features/bulkProductUpload/data/repositories/bulk_product_repository_impl.dart';
import 'package:data_table/features/bulkProductUpload/domain/usecases/bulk_product_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'bulk_product_upload_state.dart';

class BulkProductUploadCubit extends Cubit<BulkProductUploadState> {
  BulkProductUploadCubit() : super(BulkProductUploadInitial());

// use DI to inject the useCase

  final BulkProductUseCase bulkProductUseCase = BulkProductUseCase(
      repository:
          BulkProductRepositoryImpl(mockDataSource: MockDataSourceImpl()));

  Future<void> getProducts() async {
    emit(BulkProductUploadLoading());

    final products = await bulkProductUseCase();
    emit(BulkProductUploadLoaded(products: products));
  }

  void toggleSelectedProduct(BulkProductModel product) {
    final products = (state as BulkProductUploadLoaded).products;
    final List<BulkProductModel> newProducts = [
      for (var oldProduct in products)
        oldProduct == product
            ? oldProduct.copyWith(isSelected: !oldProduct.isSelected)
            : oldProduct
    ];

    emit(BulkProductUploadLoaded(products: newProducts));
  }

  void toggleSelectAll() {
    final products = (state as BulkProductUploadLoaded).products;
    final List<BulkProductModel> newProducts = [
      for (var oldProduct in products)
        oldProduct.copyWith(isSelected: !oldProduct.isSelected)
    ];

    emit(BulkProductUploadLoaded(products: newProducts));
  }
}
