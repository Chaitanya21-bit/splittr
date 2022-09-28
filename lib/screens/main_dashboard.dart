import 'package:flutter/material.dart';
import 'package:splitter/auth/firebase_manager.dart';
import 'package:splitter/dataclass/transactions.dart';
import 'package:splitter/screens/auth_screens/login_screen.dart';
import 'package:splitter/widgets/transaction_list.dart';
import 'package:intl/intl.dart';

class MainDashboard extends StatefulWidget {
  const MainDashboard({super.key});
  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  final List<Transactions> _transactionsList = [];

  final TextEditingController addMoneyController = TextEditingController();
  final TextEditingController addRemarksController = TextEditingController();
  final TextEditingController addTitleController = TextEditingController();
  bool _isIncome = false;
  DateTime? _selectedDate;

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime.now())
        .then((date) {
      if (date == null && date.toString().isEmpty) {
        return;
      }
      setState(() => _selectedDate = date!);
    });
  }

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

  Future<void> addUserTransaction(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            scrollable: true,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            title: const Center(
              child: Text('New Payment'),
            ),
            content: Form(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: TextFormField(
                    controller: addTitleController,
                    decoration: const InputDecoration(
                      labelText: 'Add Title',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8.0, bottom: 5.0),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(0.0),
                    horizontalTitleGap: 0.0,
                    trailing: Text(
                      _selectedDate == null
                          ? 'NIL'
                          : DateFormat.yMMMd().format(_selectedDate!),
                    ),
                    leading: const Icon(Icons.date_range),
                    title: TextButton(
                      child: Text(
                        'Choose Date',
                        style: Theme.of(context).textTheme.button,
                      ),
                      onPressed: _showDatePicker,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    const Text('Expense'),
                    Switch(
                      value: _isIncome,
                      onChanged: (newValue) {
                        setState(() {
                          _isIncome = newValue;
                        });
                      },
                    ),
                    const Text('Income'),
                  ],
                ),
                TextFormField(
                  controller: addMoneyController,
                  decoration: const InputDecoration(
                    labelText: 'Add money',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  controller: addRemarksController,
                  decoration: const InputDecoration(
                    labelText: 'Add Remarks',
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 25, horizontal: 5),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            )),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () => {Navigator.of(context).pop()},
                style: ButtonStyle(
                  // backgroundColor: MaterialStateProperty.all<Color>(Color(0xff42a5f5)),
                  backgroundColor:
                      MaterialStateProperty.all(const Color(0xff1870B5)),
                  overlayColor: MaterialStateProperty.all<Color>(Colors.pink),
                ),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () => {},
                style: ButtonStyle(
                  // backgroundColor: MaterialStateProperty.all<Color>(Color(0xff42a5f5)),
                  backgroundColor:
                      MaterialStateProperty.all(const Color(0xff1870B5)),
                  overlayColor: MaterialStateProperty.all<Color>(Colors.pink),
                ),
                child: const Text("ADD"),
              ),
            ],
          );
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
          await addUserTransaction(context);
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
