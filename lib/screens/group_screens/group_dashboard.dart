import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitter/auth/firebase_manager.dart';
import 'package:splitter/screens/auth_screens/login_screen.dart';
import 'package:splitter/dataclass/person.dart';
import '../../dataclass/transactions.dart';
import '../../widgets/transaction_item.dart';
import '../main_dashboard.dart';
import '../../dataclass/group.dart';
import '../../dataclass/group.dart';
import '../popup_screens/add_money_popup.dart';
import 'group_details_dropdown.dart';

class GroupDashboard extends StatefulWidget {
  // final Group group;
  const GroupDashboard({Key? key}) : super(key: key);

  @override
  State<GroupDashboard> createState() => _GroupDashboardState();
}

class _GroupDashboardState extends State<GroupDashboard> {
  late Group group;
  late Person person;

  @override
  void initState() {
    group = Provider.of<Group>(context, listen: false);
    person = Provider.of<Person>(context, listen: false);
    super.initState();
    print(group.members);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Group Dashboard'),
        centerTitle: true,
        backgroundColor: Colors.deepOrangeAccent,
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseManager.auth.signOut();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('login', (Route r) => false);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await openDialogue(context, group);
        },
        backgroundColor: Colors.deepOrange,
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child:
           Column(
                children: [
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: group.members
                              .length, //user data toh empty hai bc // nahi h khali ab mc
                          itemBuilder: (context, index) {
                            return Card(
                              child: Text(group.members[index].name.toString()),
                            );
                          }),
                  Row(children: [
                    Expanded(
                        child: GroupDetailsDropdown(
                          group: group,
                        ))
                  ]),
                  Text(group.gid),
                  Text(group.members.toString()),
                  Text(group.groupName),
                  Text("You are ${person.name}"),
                  SelectableText(group.link.toString()),
                  Consumer<Person>(
                    builder: (_, data, __) {
                      List<Transactions> transactionsList =
                      data.userTransactions.reversed.toList();
                      return ListView.builder(
                          itemCount: transactionsList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            if (index == transactionsList.length) {
                              return const SizedBox(height: 75.0);
                            }
                            return Column(
                              children: [
                                TransactionItem(transItem: transactionsList[index]),
                              ],
                            );
                          });
                    },
                  ),
                ],
              ))


    );
  }
}
