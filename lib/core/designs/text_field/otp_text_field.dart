import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpTextField extends StatelessWidget {
  final ValueChanged<String>? onChanged;

  const OtpTextField({
    super.key,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    const color = Colors.grey;
    return PinCodeTextField(
      appContext: context,
      length: 6,
      cursorColor: Colors.black,
      keyboardType: TextInputType.number,
      animationType: AnimationType.fade,
      enableActiveFill: true,
      onChanged: onChanged,
      pinTheme: PinTheme.defaults(
        borderRadius: BorderRadius.circular(10),
        shape: PinCodeFieldShape.box,
        activeColor: color,
        inactiveColor: color,
        selectedColor: color,
        activeFillColor: color.withOpacity(0.1),
        inactiveFillColor: color.withOpacity(0.1),
        selectedFillColor: color.withOpacity(0.1),
        errorBorderColor: color,
      ),
    );
  }
}
