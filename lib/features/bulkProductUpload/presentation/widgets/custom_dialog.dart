import 'package:data_table/features/bulkProductUpload/data/models/bulk_product_model.dart';
import 'package:flutter/material.dart';

/// [updateProductDialog] is a function that returns a [Future]
/// when the dialog is closed. The [Future] returns an instance
/// of [BulkProductModel] that is used to update a product
/// in the [DataTable]
Future<BulkProductModel?> updateProductDialog({
  required BuildContext context,
  required String hintText,
  required BulkProductModel product,
  required int cellIndex,
}) async {
  final controller = TextEditingController(text: hintText);
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: Container(
          padding: const EdgeInsets.all(8),
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text('Update Product'),
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: hintText,
                  border: const OutlineInputBorder(),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  var updatedCell = product;
                  switch (cellIndex) {
                    case 0:
                      updatedCell =
                          product.copyWith(productName: controller.text);
                    case 1:
                      updatedCell = product.copyWith(
                        quantity: int.tryParse(controller.text),
                      );
                  }
                  Navigator.of(context).pop(updatedCell);
                  controller.clear();
                },
                child: const Text('Update'),
              ),
            ],
          ),
        ),
      );
    },
  );
}
