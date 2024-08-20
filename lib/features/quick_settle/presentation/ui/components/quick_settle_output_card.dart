import 'package:flutter/material.dart';
import 'package:splittr/core/designs/color/app_colors.dart';

class QuickSettleOutputCard extends StatelessWidget {
  const QuickSettleOutputCard({super.key});

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
          const Text(
            'Name 1',
            style: TextStyle(color: Colors.black),
          ),
          Column(
            children: [
              const Text(
                'Amount',
                style: TextStyle(color: Colors.black),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 120,
                    height: 2,
                    color: Colors.black,
                  ),
                  Transform.translate(
                    offset: const Offset(
                      -4,
                      0,
                    ),
                    child: const Icon(
                      Icons.arrow_forward_outlined,
                      color: Colors.black,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Text(
            'Name 2',
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
