import 'package:data_table/features/bulkProductUpload/data/models/bulk_product_model.dart';
import 'package:data_table/features/bulkProductUpload/data/models/product_category_model.dart';
import 'package:data_table/features/bulkProductUpload/presentation/widgets/custom_text_field.dart';
import 'package:data_table/utils/utils.dart';
import 'package:flutter/material.dart';

import 'package:uuid/uuid.dart';

/// [addNewProduct] method returns a [Future] with a new instance of
///[BulkProductModel] when the [Dialog] is closed
Future<BulkProductModel?> addNewProduct({required BuildContext context}) async {
  final nameController = TextEditingController();
  final quantityController = TextEditingController();
  final buyingPriceController = TextEditingController();
  final sellingPriceController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? validator(String? val) {
    const message = 'value must be greater than 0 or a number';
    if (val != null) {
      final value = int.tryParse(val);
      if (value == null || value < 0) {
        return message;
      }
    }
    return null;
  }

  void onSubmit() {
    final isValid = formKey.currentState?.validate();
    if (isValid != null && isValid) {
      formKey.currentState?.save();
      final product = BulkProductModel(
        productName: nameController.text,
        quantity: int.tryParse(quantityController.text) ?? 0,
        buyingPrice: double.tryParse(buyingPriceController.text) ?? 0,
        sellingPrice: double.tryParse(sellingPriceController.text) ?? 0,
        category: ProductCategory(
          id: uuid.v4(),
          name: ProductCategoryEnum.food.name,
          subCategories: [
            ProductSubCategory(
              id: uuid.v4(),
              name: ProductSubCategoryEnum.spoons.name,
            ),
          ],
        ),
        id: uuid.v4(),
      );
      nameController.clear();
      quantityController.clear();
      sellingPriceController.clear();
      buyingPriceController.clear();

      Navigator.of(context).pop(product);
    }
  }

  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        child: Container(
          padding: const EdgeInsets.all(12),
          height: MediaQuery.sizeOf(context).height * .6,
          width: MediaQuery.sizeOf(context).width,
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Add inventory',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  FormField(
                    controller: nameController,
                    title: 'Product Name',
                    hintText: 'Product Name',
                    validator: (val) {
                      if (val == null) {
                        return 'please provide a valid product name';
                      }
                      if (val.isEmpty) {
                        return 'please provide a valid product name';
                      }
                      return null;
                    },
                  ),
                  FormField(
                    controller: quantityController,
                    title: 'Quantity',
                    keyBoardType: TextInputType.number,
                    hintText: '10',
                    validator: validator,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: FormField(
                          controller: buyingPriceController,
                          title: 'Buying Price',
                          keyBoardType: TextInputType.number,
                          hintText: '10',
                          validator: validator,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: FormField(
                          controller: sellingPriceController,
                          title: 'Selling Price',
                          keyBoardType: TextInputType.number,
                          hintText: '10',
                          validator: validator,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: onSubmit,
                    child: const Text('SAVE'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

/// [FormField] widget
class FormField extends StatelessWidget {
  /// [FormField] widget
  const FormField({
    required this.controller,
    required this.title,
    required this.hintText,
    required this.validator,
    super.key,
    this.keyBoardType = TextInputType.name,
  });

  /// [controller] instance of [TextEditingController]
  final TextEditingController controller;

  /// [title] title of the form field
  final String title;

  /// [keyBoardType] type of keyboard to display
  final TextInputType keyBoardType;

  /// [hintText] hint text to display
  final String hintText;

  /// [validator] function to validate the input
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(title),
        const SizedBox(height: 8),
        CustomTextField(
          controller: controller,
          validator: validator,
          hintText: hintText,
          keyBoardType: keyBoardType,
        ),
      ],
    );
  }
}

/// instance of [Uuid] to generate unique ids
Uuid uuid = const Uuid();
