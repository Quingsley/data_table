import 'package:data_table/features/bulkProductUpload/data/datasources/mock_data_source.dart';
import 'package:data_table/features/bulkProductUpload/data/models/bulk_product_model.dart';
import 'package:data_table/features/bulkProductUpload/data/models/product_category_model.dart';
import 'package:data_table/features/bulkProductUpload/data/repositories/bulk_product_repository_impl.dart';
import 'package:data_table/features/bulkProductUpload/domain/usecases/bulk_product_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bulk_product_upload_state.dart';

/// [BulkProductUploadCubit] is a [Cubit] that manages the state of
/// the screen that displays the list of products in a data table
class BulkProductUploadCubit extends Cubit<BulkProductUploadState> {
  /// [BulkProductUploadCubit] constructor
  BulkProductUploadCubit() : super(BulkProductUploadInitial());

  // /// [Debounce] instance
  // final Debounce _debounce =
  //     Debounce(interval: const Duration(milliseconds: 500));
  late final List<BulkProductModel> _initialProducts;

// use DI to inject the useCase
  /// [BulkProductUseCase] instance
  final BulkProductUseCase bulkProductUseCase = BulkProductUseCase(
    repository: BulkProductRepositoryImpl(mockDataSource: MockDataSourceImpl()),
  );

  /// [products] getter that returns the list of products
  List<BulkProductModel> get products => _initialProducts;

  /// [getProducts] method that gets the list of products
  Future<void> getProducts() async {
    emit(BulkProductUploadLoading());

    final products = await bulkProductUseCase();
    _initialProducts = products;
    emit(BulkProductUploadLoaded(products: products));
  }

  /// [toggleSelectedProduct] method that toggles the selected product
  void toggleSelectedProduct(BulkProductModel product) {
    final products = (state as BulkProductUploadLoaded).products;
    // final products = [..._initialProducts];
    final newProducts = <BulkProductModel>[
      for (final oldProduct in products)
        oldProduct == product
            ? oldProduct.copyWith(isSelected: !oldProduct.isSelected)
            : oldProduct,
    ];

    emit(BulkProductUploadLoaded(products: newProducts));
  }

  // /// [toggleSelectAll] method that toggles all the products
  // ///  to be selected in the data table
  // void toggleSelectAll() {
  //   final products = (state as BulkProductUploadLoaded).products;
  //   // final products = [..._initialProducts];
  //   final newProducts = <BulkProductModel>[
  //     for (final oldProduct in products)
  //       oldProduct.copyWith(isSelected: !oldProduct.isSelected),
  //   ];

  //   emit(BulkProductUploadLoaded(products: newProducts));
  // }

  /// [updateProduct] method that updates the product
  void updateProduct(BulkProductModel newProduct) {
    final products = [..._initialProducts];

    final newProducts = <BulkProductModel>[
      for (final oldProduct in products)
        oldProduct.id == newProduct.id ? newProduct : oldProduct,
    ];

    emit(BulkProductUploadLoaded(products: newProducts));
  }

  // /// [sortColumn] method that sorts the column either
  // /// in ascending or descending order
  // void sortColumn(ProductColumnsEnum column, {required bool isAscending}) {
  //   final products = [..._initialProducts];
  //   switch (column) {
  //     case ProductColumnsEnum.buyingPrice:
  //       products.sort(
  //         (p0, p1) => isAscending
  //             ? p0.buyingPrice.compareTo(p1.buyingPrice)
  //             : p1.buyingPrice.compareTo(p0.buyingPrice),
  //       );
  //     case ProductColumnsEnum.quantity:
  //       products.sort(
  //         (p0, p1) => isAscending
  //             ? p0.quantity.compareTo(p1.quantity)
  //             : p1.quantity.compareTo(p0.quantity),
  //       );
  //     case ProductColumnsEnum.sellingPrice:
  //       products.sort(
  //         (p0, p1) => isAscending
  //             ? p0.sellingPrice.compareTo(p1.sellingPrice)
  //             : p1.sellingPrice.compareTo(p0.sellingPrice),
  //       );
  //     case ProductColumnsEnum.productName:
  //       products.sort(
  //         (p0, p1) => isAscending
  //             ? p0.productName.compareTo(p1.productName)
  //             : p1.productName.compareTo(p0.productName),
  //       );
  //   }
  //   emit(BulkProductUploadLoaded(products: products));
  // }

  /// used to filter the products based on the selected category
  void filterProducts(
    ProductSubCategory selectedCategory, {
    required bool isSelected,
  }) {
    final products = [..._initialProducts];
    final selectedProducts = products
        .where(
      (product) => product.category.subCategories.contains(selectedCategory),
    )
        .map((c) {
      final newSubCategories = c.category.subCategories.map((sub) {
        if (sub.id == selectedCategory.id) {
          return sub.copyWith(isSelected: isSelected);
        }
        return sub;
      }).toList();
      final newCategories =
          c.category.copyWith(subCategories: newSubCategories);
      return c.copyWith(category: newCategories);
    }).toList();

    emit(BulkProductUploadLoaded(products: selectedProducts));
  }

  // /// [searchProductByName] method that searches the product by name
  // void searchProductByName(String searchTerm) {
  //   final products = [..._initialProducts];
  //   // call reset to cancel the previous call
  //   _debounce
  //     ..reset()
  //     ..call(() {
  //       final searchedProducts = products
  //           .where(
  //             (product) => product.productName
  //                 .toLowerCase()
  //                 .contains(searchTerm.toLowerCase()),
  //           )
  //           .toList();

  //       emit(BulkProductUploadLoaded(products: searchedProducts));
  //     });
  // }

  /// [reset] method resets the state upon resetting filtering or searching
  void reset() {
    emit(BulkProductUploadLoaded(products: _initialProducts));
  }

  /// deletes products from the list
  void deleteProduct() {
    final products = (state as BulkProductUploadLoaded).products;
    final filteredProducts =
        products.where((product) => !product.isSelected).toList();
    emit(BulkProductUploadLoaded(products: filteredProducts));
  }

  /// adds new products to the list
  void addProduct(BulkProductModel newProduct) {
    final products = (state as BulkProductUploadLoaded).products;
    final newProducts = [...products, newProduct];
    _initialProducts.add(newProduct);
    emit(BulkProductUploadLoaded(products: newProducts));
  }
}
