import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  const InputTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.textInputAction,
    this.padding,
    this.enable,
  });

  final TextEditingController controller;
  final String labelText;
  final TextInputType? textInputAction;
  final EdgeInsetsGeometry? padding;
  final bool? enable;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextFormField(
        controller: controller,
        textCapitalization: TextCapitalization.sentences,
        keyboardType: textInputAction,
        obscureText: labelText.contains("Password"),
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          labelText: labelText,
        ),
        enabled: enable,
      ),
    );
  }
}
