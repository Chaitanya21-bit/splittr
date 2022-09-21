import 'package:flutter/material.dart';
import 'package:splitter/auth/firebase_manager.dart';
import 'package:splitter/dataclass/transactions.dart';
import 'package:splitter/screens/auth_screens/login_screen.dart';
import 'package:splitter/widgets/transaction_list.dart';
import 'popup_screens/add_money_popup.dart';

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
      centerTitle: true,
      backgroundColor: Colors.teal,
      actions: [
        IconButton(
            onPressed: () {
              FirebaseManager.auth.signOut();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            icon: const Icon(Icons.logout))
      ],
    );

    final txList = SizedBox(
        height: ((mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.7),
        child: TransactionList(
            transactions: _transactionsList,
            deleteTransaction: _deleteTransaction));

    return Scaffold(
      appBar: appBar,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await openDialogue(context);
          // _addTransaction(transTitle, amount, selectedDate, expInc, transRemarks);
        },
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add),
      ),
      body: Container(
        height: (MediaQuery.of(context).size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            0.5,
        child: TransactionList(
            transactions: _transactionsList.reversed.toList(),
            deleteTransaction: _deleteTransaction),
      ),
    );
  }
}
