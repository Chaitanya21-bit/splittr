import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:splitter/colors.dart';
import 'package:splitter/providers/personal_transaction_provider.dart';
import 'package:splitter/utils/get_provider.dart';

import '../../../../components/cards/transaction_card.dart';
import '../../../../dataclass/dataclass.dart';

class PersonalTransactionsWidget extends StatelessWidget {
  const PersonalTransactionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final personalTransactionProvider =
        getProvider<PersonalTransactionProvider>(context, listen: true);
    if (personalTransactionProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),

      child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX:30,sigmaY: 30),
          child: Container(
              color: AppColors().black.withOpacity(0.15),

              child:
              personalTransactionProvider.personalTransactions.isEmpty
              ? const EmptyTransactions()
              : PersonalTransactionsListView(
                  personalTransactionsList: personalTransactionProvider
                      .personalTransactions)
          ),
      ),
    );
  }
}

class EmptyTransactions extends StatelessWidget {
  const EmptyTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: Text(
          "No Transactions",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15.0,
            color: AppColors().black,
          ),
        ),
    );
  }
}

class PersonalTransactionsListView extends StatelessWidget {
  const PersonalTransactionsListView(
      {super.key, required this.personalTransactionsList});

  final List<PersonalTransaction> personalTransactionsList;


  @override
  Widget build(BuildContext context) {
    final itemCount = personalTransactionsList.length;
    return ListView.builder(
          itemCount: itemCount,
          itemBuilder: (context, index) {
            return TransactionCard(transaction: personalTransactionsList[itemCount-index-1]);
          },
    );
  }
}
