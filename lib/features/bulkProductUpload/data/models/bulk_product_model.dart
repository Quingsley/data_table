import 'package:equatable/equatable.dart';

class BulkProductModel extends Equatable {
  const BulkProductModel(
      {required this.productName,
      required this.quantity,
      required this.buyingPrice,
      required this.sellingPrice,
      this.isSelected = false});

  final String productName;
  final int quantity;
  final double buyingPrice;
  final double sellingPrice;
  final bool isSelected;

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
    );
  }

  @override
  List<Object?> get props =>
      [productName, quantity, buyingPrice, sellingPrice, isSelected];

  @override
  bool? get stringify => true;
}
