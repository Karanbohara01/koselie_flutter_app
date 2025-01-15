import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.onPressed,
    required this.text,
    required this.controller,
  });

  final void Function() onPressed;
  final String text;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: text,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter $text';
        }
        return null;
      },
    );
  }
}
