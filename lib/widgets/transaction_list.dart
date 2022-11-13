import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitter/dataclass/person.dart';
import 'package:splitter/dataclass/transactions.dart';
import 'package:splitter/widgets/transaction_item.dart';

class TransactionList extends StatelessWidget {
  final Function _deleteTransaction;
  final List<Transactions> _transactionsList;

  const TransactionList(
      {super.key,
      required List<Transactions> transactionsList,
      required Function deleteTransaction})
      : _transactionsList = transactionsList,
        _deleteTransaction = deleteTransaction;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _transactionsList.length,
        itemBuilder: (context, index) {
          if (index == _transactionsList.length) {
            return const SizedBox(height: 75.0);
          }
          return Column(
            children: [
              TransactionItem(
                transItem: _transactionsList[index],
                deleteTransaction: _deleteTransaction,
              ),
            ],
          );
        });
  }
}
