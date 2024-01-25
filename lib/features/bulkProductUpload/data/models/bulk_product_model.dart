import 'package:equatable/equatable.dart';

/// [BulkProductModel] is a model class that holds the data
/// for a single product
class BulkProductModel extends Equatable {
  /// constructor of [BulkProductModel]
  const BulkProductModel({
    required this.productName,
    required this.quantity,
    required this.buyingPrice,
    required this.sellingPrice,
    required this.id,
    this.isSelected = false,
  });

  /// uuid
  final String id;

  /// name of the product
  final String productName;

  /// quantity of the product
  final int quantity;

  /// buying price of the product
  final double buyingPrice;

  /// selling price of the product
  final double sellingPrice;

  /// whether the product is selected or not
  final bool isSelected;

  /// returns a copy of the [BulkProductModel] with the
  /// specified fields replaced with the new values
  BulkProductModel copyWith({
    String? productName,
    int? quantity,
    double? buyingPrice,
    double? sellingPrice,
    bool? isSelected,
  }) {
    return BulkProductModel(
      productName: productName ?? this.productName,
      quantity: quantity ?? this.quantity,
      buyingPrice: buyingPrice ?? this.buyingPrice,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      isSelected: isSelected ?? this.isSelected,
      id: id,
    );
  }

  @override
  List<Object?> get props =>
      [productName, quantity, buyingPrice, sellingPrice, isSelected, id];

  @override
  bool? get stringify => true;
}
