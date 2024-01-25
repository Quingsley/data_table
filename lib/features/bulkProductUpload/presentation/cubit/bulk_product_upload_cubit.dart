import 'package:data_table/features/bulkProductUpload/data/datasources/mock_data_source.dart';
import 'package:data_table/features/bulkProductUpload/data/models/bulk_product_model.dart';
import 'package:data_table/features/bulkProductUpload/data/repositories/bulk_product_repository_impl.dart';
import 'package:data_table/features/bulkProductUpload/domain/usecases/bulk_product_usecase.dart';
import 'package:data_table/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bulk_product_upload_state.dart';

/// [BulkProductUploadCubit] is a [Cubit] that manages the state of
/// the screen that displays the list of products in a data table
class BulkProductUploadCubit extends Cubit<BulkProductUploadState> {
  /// [BulkProductUploadCubit] constructor
  BulkProductUploadCubit() : super(BulkProductUploadInitial());

// use DI to inject the useCase
  /// [BulkProductUseCase] instance
  final BulkProductUseCase bulkProductUseCase = BulkProductUseCase(
    repository: BulkProductRepositoryImpl(mockDataSource: MockDataSourceImpl()),
  );

  /// [getProducts] method that gets the list of products
  Future<void> getProducts() async {
    emit(BulkProductUploadLoading());

    final products = await bulkProductUseCase();
    emit(BulkProductUploadLoaded(products: products));
  }

  /// [toggleSelectedProduct] method that toggles the selected product
  void toggleSelectedProduct(BulkProductModel product) {
    final products = (state as BulkProductUploadLoaded).products;
    final newProducts = <BulkProductModel>[
      for (final oldProduct in products)
        oldProduct == product
            ? oldProduct.copyWith(isSelected: !oldProduct.isSelected)
            : oldProduct,
    ];

    emit(BulkProductUploadLoaded(products: newProducts));
  }

  /// [toggleSelectAll] method that toggles all the products
  ///  to be selected in the data table
  void toggleSelectAll() {
    final products = (state as BulkProductUploadLoaded).products;
    final newProducts = <BulkProductModel>[
      for (final oldProduct in products)
        oldProduct.copyWith(isSelected: !oldProduct.isSelected),
    ];

    emit(BulkProductUploadLoaded(products: newProducts));
  }

  /// [updateProduct] method that updates the product
  void updateProduct(BulkProductModel newProduct) {
    final products = (state as BulkProductUploadLoaded).products;

    final newProducts = <BulkProductModel>[
      for (final oldProduct in products)
        oldProduct.id == newProduct.id ? newProduct : oldProduct,
    ];

    emit(BulkProductUploadLoaded(products: newProducts));
  }

  /// [sortColumn] method that sorts the column either
  /// in ascending or descending order
  void sortColumn(ProductColumns column, {required bool isAscending}) {
    switch (column) {
      case ProductColumns.buyingPrice:
        final products = (state as BulkProductUploadLoaded).products;
        products.sort(
          (p0, p1) => isAscending
              ? p0.buyingPrice.compareTo(p1.buyingPrice)
              : p1.buyingPrice.compareTo(p0.buyingPrice),
        );
      case ProductColumns.quantity:
        final products = (state as BulkProductUploadLoaded).products;
        products.sort(
          (p0, p1) => isAscending
              ? p0.quantity.compareTo(p1.quantity)
              : p1.quantity.compareTo(p0.quantity),
        );
      case ProductColumns.sellingPrice:
        final products = (state as BulkProductUploadLoaded).products;
        products.sort(
          (p0, p1) => isAscending
              ? p0.sellingPrice.compareTo(p1.sellingPrice)
              : p1.sellingPrice.compareTo(p0.sellingPrice),
        );
      case ProductColumns.productName:
        final products = (state as BulkProductUploadLoaded).products;
        products.sort(
          (p0, p1) => isAscending
              ? p0.productName.compareTo(p1.productName)
              : p1.productName.compareTo(p0.productName),
        );
    }
  }
}
