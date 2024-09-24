import 'package:flutter/material.dart';
import 'package:splittr/core/designs/color/app_colors.dart';

class QuickSettleOutputTextCard extends StatelessWidget {
  final String sender;
  final String receiver;
  final String amount;
  const QuickSettleOutputTextCard({
    super.key,
    required this.sender,
    required this.receiver,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.greyColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          '$sender has to pay $amount to $receiver.',
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
