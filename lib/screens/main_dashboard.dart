import 'package:flutter/material.dart';
import 'package:splitter/dataclass/transactions.dart';
import 'package:splitter/widgets/transaction_list.dart';

class MainDashboard extends StatefulWidget {
  const MainDashboard({super.key});
  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  final List<Transactions> _transactionsList = [];

  void _addTransaction(String transTitle, double amount, DateTime selectedDate,
      String expInc, String transRemarks) {
    final newTrans = Transactions(
        tid: DateTime.now().toString(),
        title: transTitle,
        amount: amount,
        date: selectedDate,
        expenseOrIncome: expInc,
        remarks: transRemarks);

    setState(() {
      _transactionsList.add(newTrans);
    });
  }

  void _deleteTransaction(String transId) {
    setState(() {
      _transactionsList.removeWhere((index) => (index.tid == transId));
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final dynamic appBar = AppBar(
      title: const Text('Dashboard'),
    );

    final txList = SizedBox(
        height: ((mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.7),
        child: TransactionList(
            transactions: _transactionsList,
            deleteTransaction: _deleteTransaction));

    return Container();
  }
}
