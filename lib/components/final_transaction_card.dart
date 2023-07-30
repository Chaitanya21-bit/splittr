import 'dart:ui';

import 'package:flutter/material.dart';

import '../constants/colors.dart';

class FinalTransactionCard extends StatefulWidget {
  final Widget child;

  const FinalTransactionCard({Key? key, required this.child}) : super(key: key);

  @override
  State<FinalTransactionCard> createState() => _FinalTransactionCardState();
}

class _FinalTransactionCardState extends State<FinalTransactionCard> {

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
                color: AppColors.black.withOpacity(0.25),

                child: Card(
                    margin: const EdgeInsets.all(5),
                    child: widget.child,
                    )
                )
            )
    );
  }
}
