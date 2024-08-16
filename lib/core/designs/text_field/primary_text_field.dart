import 'package:flutter/material.dart';
import 'package:splittr/utils/keyboard/keyboard_utils.dart';

class PrimaryTextField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;
  final int? maxLength;
  final bool obscureText;

  const PrimaryTextField({
    super.key,
    this.labelText,
    this.hintText,
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
    return SizedBox(
      height: 40, // Set the height
      width: 300, // Set the width
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        onEditingComplete: () => _onEditingComplete(context),
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        maxLength: maxLength,
        obscureText: obscureText,
        style: const TextStyle(
          fontSize: 13, // Reduce the font size
        ),
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 12, // Increase vertical padding
            horizontal: 16, // Increase horizontal padding
          ),
        ),
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
