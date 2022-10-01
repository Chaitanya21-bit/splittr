import 'package:flutter/material.dart';
import 'package:splitter/dataclass/transactions.dart';
import 'package:splitter/widgets/transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<dynamic> _transactions;
  final Function _deleteTransaction;

  TransactionList(
      {required List<dynamic> transactions,
      required Function deleteTransaction})
      : _transactions = transactions,
        _deleteTransaction = deleteTransaction;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _transactions.length,
      itemBuilder: (context, index) {
        if (index == _transactions.length) {
          return SizedBox(height: 75.0);
        }
        // if (index != 0 && index % 3 == 0 && _transactions.length > 4)
        return Column(
          children: [
            TransactionItem(
              transItem: _transactions[index],
              deleteTransaction: _deleteTransaction,
            ),
          ],
        );
      },
    );
  }
}
