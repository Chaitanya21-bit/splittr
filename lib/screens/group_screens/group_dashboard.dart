import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:splitter/auth/firebase_manager.dart';
import 'package:splitter/screens/auth_screens/login_screen.dart';
import 'package:splitter/dataclass/person.dart';
import '../../dataclass/transactions.dart';
import '../../widgets/transaction_item.dart';
import '../main_dashboard.dart';
import '../../dataclass/group.dart';
import '../../dataclass/group.dart';
import '../popup_screens/group_transaction_popup.dart';
import 'group_details_dropdown.dart';
import 'group_details_popup.dart';

class GroupDashboard extends StatefulWidget {
  final Group group;
  const GroupDashboard({Key? key, required this.group}) : super(key: key);

  @override
  State<GroupDashboard> createState() => _GroupDashboardState();
}

class _GroupDashboardState extends State<GroupDashboard> {
  late Group group;
  late Person person;

  @override
  void initState() {
    group = widget.group;
    person = Provider.of<Person>(context, listen: false);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Group>(
            create: (context) => group
        ),
      ],
      child: Scaffold(
          floatingActionButton: ElevatedButton.icon(
            onPressed: () async {
                  await openDialogue(context, group, person);
            },
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 25,
                ),
                backgroundColor: Color(0xff223146),
                foregroundColor: Colors.white,
                shadowColor: Colors.blueAccent,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                )
            ),
            icon: const Text("Add"),
            label: const Icon(Icons.add_circle,),
          ),

          body: SingleChildScrollView(
              child:
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.05,
                      bottom: MediaQuery.of(context).size.height * 0.05,
                    ),
                    child: Image.asset("assets/SplittrLogo.png",
                      width: MediaQuery.of(context).size.height * 0.2,
                    )
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))
                    ),
                    color: Color(0xff223146),
                    clipBehavior: Clip.hardEdge,
                    child:  InkWell(
                        splashColor: Colors.blueAccent,
                        onTap: ()
                          async {
                            await groupDetails(context, group);
                            debugPrint('Open POP UP');
                          },

                        child:
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 6,
                              width: MediaQuery.of(context).size.width - 50,
                        child:
                            Padding(
                                padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height * 0.02,
                                  left: MediaQuery.of(context).size.width * 0.07,
                                ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(group.groupName,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 25
                                  ),
                                ),
                                Text('${group.members.length.toString()} Members',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400, fontSize: 15,
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.width * 0.02,
                                ),
                                  child: TextButton(     // <-- TextButton
                                    onPressed: () {_copyToClipboard();},
                                    child: Text('Copy Link',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        decoration: TextDecoration.underline,
                                      ),),

                                    style: ButtonStyle(
                                      foregroundColor: MaterialStateProperty.all(const Color(0xff1870B5)),
                                    ),
                                  ),
                                )
                              ],
                            )

                        ),
                      ),
                    ),
                  ),

                  // ListView.builder(
                  //     shrinkWrap: true,
                  //     itemCount: group.members.length, //user data toh empty hai bc // nahi h khali ab mc
                  //     itemBuilder: (context, index) {
                  //       return Card(
                  //         child: Text(group.members[index].name.toString()),
                  //       );
                  //     }),

                  // Row(
                  //     children: [
                  //   Expanded(
                  //       child: GroupDetailsDropdown(
                  //         group: group,
                  //       )
                  //     )
                  //   ]
                  // ),

                  // Text(group.gid),
                  // Text(group.members.toString()),
                  // Text(group.groupName),
                  Text("You are ${person.name}"),
                  // SelectableText(group.link.toString()),
                  Divider(
                    color: Colors.black,
                    indent: 50,
                    endIndent: 50,
                    thickness: 2,
                  ),
                  ListView.builder(
                      itemCount: group.transactions.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        if (index == group.transactions.length) {
                          return const SizedBox(height: 75.0);
                        }
                        return TransactionItem(transItem: group.transactions[index]);
                      }),
                ],
              ))


      ),
    );
  }
  Future<void> _copyToClipboard() async {
    await Clipboard.setData(ClipboardData(text: widget.group.link.toString()));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Copied to clipboard'),
    ));
  }
}
