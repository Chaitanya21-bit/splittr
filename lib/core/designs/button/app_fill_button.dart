import 'package:flutter/material.dart';

class AppFillButton extends StatelessWidget {
  final String text;
  final Color fillColor;
  final Color borderColor;
  final Color textColor;
  final VoidCallback onTap;

  const AppFillButton({
    super.key,
    required this.text,
    required this.fillColor,
    required this.borderColor,
    required this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: double.infinity,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: fillColor, // Fill color
            border: Border.all(color: borderColor), // Border color
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: textColor, // Text color
            ),
          ),
        ),
      ),
    );
  }
}
