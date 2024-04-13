import 'package:flutter/material.dart';
import 'package:splittr/utils/keyboard/keyboard_utils.dart';

class PrimaryTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;
  final int? maxLength;
  final bool obscureText;

  const PrimaryTextField({
    super.key,
    required this.labelText,
    required this.hintText,
    this.controller,
    this.onChanged,
    this.onEditingComplete,
    this.keyboardType,
    this.textInputAction = TextInputAction.done,
    this.maxLength,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      onEditingComplete: () => _onEditingComplete(context),
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      maxLength: maxLength,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: const OutlineInputBorder(),
      ),
    );
  }

  void _onEditingComplete(BuildContext context) {
    onEditingComplete?.call();

    if (textInputAction == TextInputAction.done) {
      hideKeyboard(context);
    }
  }
}
