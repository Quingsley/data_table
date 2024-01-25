part of 'bulk_product_upload_cubit.dart';

/// [BulkProductUploadCubit] is a [Cubit] that manages the state of
/// screen that displays the list of products
abstract class BulkProductUploadState extends Equatable {
  /// [BulkProductUploadState] constructor
  const BulkProductUploadState();

  @override
  List<Object> get props => [];
}

/// initial state
class BulkProductUploadInitial extends BulkProductUploadState {}

/// loading state
class BulkProductUploadLoading extends BulkProductUploadState {}

/// loaded state
class BulkProductUploadLoaded extends BulkProductUploadState {
  /// [BulkProductUploadLoaded] constructor
  const BulkProductUploadLoaded({required this.products});

  /// list of products
  final List<BulkProductModel> products;

  @override
  List<Object> get props => [products];
}

// add error state
