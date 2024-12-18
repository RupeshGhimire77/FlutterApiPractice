import 'package:flutter/material.dart';

class CustomTextformField extends StatelessWidget {
  String? labelText;
  TextInputType? keyboardType;
  void Function(String)? onChanged;
  String? Function(String?)? validator;
  TextEditingController? controller;

  CustomTextformField(
      {super.key,
      this.labelText,
      this.keyboardType,
      this.onChanged,
      this.validator,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
      keyboardType: keyboardType,
      onChanged: onChanged,
      validator: validator,
      controller: controller,
    );
  }
}
