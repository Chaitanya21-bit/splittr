import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:splitter/auth/firebase_manager.dart';
import 'package:splitter/dataclass/person.dart';
import 'package:splitter/dataclass/transactions.dart';
import 'package:splitter/screens/auth_screens/login_screen.dart';
import 'package:splitter/screens/popup_screens/new_group_popup.dart';
import 'package:splitter/widgets/group_item.dart';
import 'package:splitter/widgets/navigation_drawer.dart';
import 'package:splitter/widgets/transaction_list.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import 'popup_screens/join_group_popup.dart';

final FirebaseDatabase database = FirebaseManager.database;
final FirebaseAuth _auth = FirebaseAuth.instance;

class MainDashboard extends StatefulWidget {
  const MainDashboard({super.key});
  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  // final List<Transactions> _transactionsList = [];

  final TextEditingController addMoneyController = TextEditingController();
  final TextEditingController addRemarksController = TextEditingController();
  final TextEditingController addTitleController = TextEditingController();
  // bool _isIncome = false;
  String _selectedDate = DateTime.now().toString();

  List<dynamic> outputTransactionsList = [];
  List<dynamic> outputGroupsList = [];

  @override
  void initState() {
    super.initState();
    _retrieveTransaction(context);
    _retrieveGroup(context);
  }

  _retrieveTransaction(BuildContext context) async {
    final snapshot1 = await database.ref('Transactions').get();
    // print(snapshot1.value);

    Map<String, dynamic> map1 =
        Map<String, dynamic>.from(snapshot1.value as Map<dynamic, dynamic>);
    List<dynamic> list1 = [];
    list1.clear();
    list1 = map1.values.toList();
    print(list1);

    final snapshot2 =
        await database.ref().child('Users/${_auth.currentUser!.uid}').get();
    // print(snapshot2.value);
    Map<String, dynamic> map2 =
        Map<String, dynamic>.from(snapshot2.value as Map<dynamic, dynamic>);
    Person P = Person.fromJson(map2);
    print(P.userTransactions);

    for (int i = 0; i < P.userTransactions.length; i++) {
      for (int j = 0; j < list1.length; j++) {
        if (P.userTransactions[i] == list1[j]['tid']) {
          if (!outputTransactionsList.contains(list1[j])) {
            outputTransactionsList.add(list1[j]);
          }
        }
      }
      // list1.removeWhere((item) => item.tid == P.userTransactions[i]);
    }
    setState(() {
      outputTransactionsList;
    });
    print(outputTransactionsList);
  }

  _retrieveGroup(BuildContext context) async {
    final snapshot4 = await database.ref('Group').get();
    // print(snapshot1.value);

    Map<String, dynamic> map1 =
        Map<String, dynamic>.from(snapshot4.value as Map<dynamic, dynamic>);
    List<dynamic> list2 = [];
    list2.clear();
    list2 = map1.values.toList();
    print(list2);

    final snapshot3 =
        await database.ref().child('Users/${_auth.currentUser!.uid}').get();
    // print(snapshot2.value);
    Map<String, dynamic> map2 =
        Map<String, dynamic>.from(snapshot3.value as Map<dynamic, dynamic>);
    Person P = Person.fromJson(map2);
    print(P.userGroups);

    for (int i = 0; i < P.userGroups.length; i++) {
      for (int j = 0; j < list2.length; j++) {
        if (P.userGroups[i] == list2[j]['gid']) {
          if (!outputGroupsList.contains(list2[j])) {
            outputGroupsList.add(list2[j]);
          }
        }
      }
    }
    setState(() {
      outputGroupsList;
    });
    print(outputGroupsList);
  }

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
      setState(() => _selectedDate = date.toString());
    });
  }

  _addTransaction(BuildContext context) async {
    try {
      NavigatorState state = Navigator.of(context);
      Person P;
      print(_auth.currentUser?.uid);
      // DataSnapshot lt = await database
      //     .ref('Users/${_auth.currentUser?.uid}/userTransactions')
      //     .get();
      // print(lt.value);

      final snapshot =
          await database.ref().child('Users/${_auth.currentUser!.uid}').get();
      print(snapshot.value);

      Map<String, dynamic> map =
          Map<String, dynamic>.from(snapshot.value as Map<dynamic, dynamic>);
      P = Person.fromJson(map);

      print(P.userTransactions);

      if (addTitleController.text.isEmpty ||
          addMoneyController.text.isEmpty ||
          _selectedDate.isEmpty) {
        return;
      }
      var dt = DateTime.parse(_selectedDate);

      const t_uuid = Uuid();
      Transactions newTrans = Transactions(
          date:
              "${dt.day}-${dt.month}-${dt.year} ${dt.hour}:${dt.minute}:${dt.second}",
          amount: double.parse(addMoneyController.text),
          title: addTitleController.text,
          remarks: addRemarksController.text,
          tid: t_uuid.v1());

      setState(() {
        if (!outputTransactionsList.contains(newTrans.toJson())) {
          outputTransactionsList.add(newTrans.toJson());
        }
      });
      print("Transaction Created");
      await database.ref('Transactions/${newTrans.tid}').set(newTrans.toJson());
      print("Transaction Stored");

      if (P.userTransactions.contains("null")) {
        P.userTransactions[P.userTransactions
            .indexWhere((element) => element == "null")] = newTrans.tid;
      } else {
        P.userTransactions.add(newTrans.tid);
      }
      // await database
      //     .ref().child(
      //         'Users/${_auth.currentUser?.uid}/userTransactions/${newTrans.tid}')
      //     .set(newTrans.toJson());

      await database.ref('Users/${_auth.currentUser?.uid}').update(P.toJson());
      print("User Upated");

      // state.pushReplacement(
      //     MaterialPageRoute(builder: (context) => MainDashboard()));
    } catch (e) {
      print(e);
    }

    addTitleController.clear();
    addMoneyController.clear();
    addRemarksController.clear();
    // _selectedDate = null;
  }

  _deleteTransaction(BuildContext context, String transId) async {
    final snapshot2 =
        await database.ref().child('Users/${_auth.currentUser!.uid}').get();
    Map<String, dynamic> map2 =
        Map<String, dynamic>.from(snapshot2.value as Map<dynamic, dynamic>);
    Person P = Person.fromJson(map2);

    setState(() {
      for (int j = 0; j < P.userTransactions.length; j++) {
        if (P.userTransactions[j] == transId) {
          P.userTransactions.removeAt(j);
          database.ref('Users/${_auth.currentUser?.uid}').update(P.toJson());
        }
      }
      outputTransactionsList
          .removeWhere((element) => (element['tid'] == transId));
      FirebaseDatabase.instance.ref().child('Transactions/$transId').remove();
    });
  }

  _deleteGroup(BuildContext context, String groupId) async {
    final snapshot2 =
        await database.ref().child('Users/${_auth.currentUser!.uid}').get();
    Map<String, dynamic> map2 =
        Map<String, dynamic>.from(snapshot2.value as Map<dynamic, dynamic>);
    Person P = Person.fromJson(map2);

    setState(() {
      for (int j = 0; j < P.userGroups.length; j++) {
        if (P.userGroups[j] == groupId) {
          FirebaseDatabase.instance
              .ref()
              .child('Users/${_auth.currentUser!.uid}/userGroups/$j')
              .remove();
          // P.userTransactions.removeAt(j);
        }
      }
      outputGroupsList.removeWhere((element) => (element['gid'] == groupId));
      FirebaseDatabase.instance.ref().child('Group/$groupId').remove();
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
                      _selectedDate.isEmpty
                          ? 'NIL'
                          : DateFormat.yMMMd()
                              .format(DateTime.parse(_selectedDate)),
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
                // Row(
                //   children: [
                //     const Text('Expense'),
                //     Switch(
                //       value: _isIncome,
                //       onChanged: (newValue) {
                //         setState(() {
                //           _isIncome = newValue;
                //         });
                //       },
                //     ),
                //     const Text('Income'),
                //   ],
                // ),
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
                onPressed: () =>
                    {_addTransaction(context), Navigator.of(context).pop()},
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

    return Scaffold(
      appBar: appBar,
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await addUserTransaction(context);
        },
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Container(
            height: (MediaQuery.of(context).size.height -
                    appBar.preferredSize.height -
                    MediaQuery.of(context).padding.top) *
                0.3,
            margin: const EdgeInsets.all(10.0),
            width: 400,
            child: ListView.builder(
                itemCount: outputGroupsList.length,
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return GroupItem(
                    groupItem: outputGroupsList[index],
                    deleteGroup: _deleteGroup,
                  );
                }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () async {
                  await joinGroup(context);
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(const Color(0xff1870B5)),
                  overlayColor: MaterialStateProperty.all<Color>(Colors.pink),
                ),
                child: const Text("Join Group"),
              ),
              ElevatedButton(
                onPressed: () async {
                  await newGroup(context);
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xff42a5f5)),
                  // backgroundColor: MaterialStateProperty.all(const Color(0xff1870B5)),
                  overlayColor: MaterialStateProperty.all<Color>(Colors.pink),
                ),
                child: const Text("New Group"),
              ),
            ],
          ),
          Container(
            height: (MediaQuery.of(context).size.height -
                    appBar.preferredSize.height -
                    MediaQuery.of(context).padding.top) *
                0.585,
            child: TransactionList(
                transactions: outputTransactionsList.reversed.toList(),
                deleteTransaction: _deleteTransaction),
          ),
        ],
      ),
      drawer: const NavigationDrawerWidget(),
    );
  }
}
