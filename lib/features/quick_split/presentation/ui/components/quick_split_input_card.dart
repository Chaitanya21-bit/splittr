import 'package:flutter/material.dart';
import 'package:splittr/core/designs/color/app_colors.dart';
import 'package:splittr/core/designs/text_field/primary_text_field.dart';

class QuickSplitInputCard extends StatelessWidget {
  final VoidCallback onDelete;
  final ValueChanged<String> onPersonNameChanged;
  final ValueChanged<String> onAmountChanged;
  const QuickSplitInputCard({
    super.key,
    required this.onDelete,
    required this.onPersonNameChanged,
    required this.onAmountChanged,
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Name',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                PrimaryTextField(onChanged: onPersonNameChanged),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Amount', // Replace with your label text
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                PrimaryTextField(
                  onChanged: onAmountChanged,
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          IconButton(onPressed: onDelete, icon: const Icon(Icons.delete)),
        ],
      ),
    );
  }
}
