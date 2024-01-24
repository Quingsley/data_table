part of 'bulk_product_upload_cubit.dart';

abstract class BulkProductUploadState extends Equatable {
  const BulkProductUploadState();

  @override
  List<Object> get props => [];
}

class BulkProductUploadInitial extends BulkProductUploadState {}

class BulkProductUploadLoading extends BulkProductUploadState {}

class BulkProductUploadLoaded extends BulkProductUploadState {
  final List<BulkProductModel> products;

  const BulkProductUploadLoaded({required this.products});

  @override
  List<Object> get props => [products];
}

// add error state