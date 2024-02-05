import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.controller,
      this.keyBoardType = TextInputType.name,
      required this.hintText,
      this.validator});

  final TextEditingController controller;
  final TextInputType keyBoardType;
  final String hintText;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
    );
    return TextFormField(
      controller: controller,
      keyboardType: keyBoardType,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        enabledBorder: border,
        border: border,
        focusedBorder: border,
      ),
    );
  }
}
