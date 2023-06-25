import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:splitter/components/dialogs/add_group_transaction_dialog.dart';
import 'package:splitter/providers/providers.dart';

import '../../size_config.dart';
import '../../utils/get_provider.dart';
import '../../utils/toasts.dart';
import 'group_details_popup.dart';

class GroupDashboard extends StatelessWidget {
  const GroupDashboard({Key? key}) : super(key: key);

  Future<void> _copyToClipboard(String data) async {
    await Clipboard.setData(ClipboardData(text: data));
    showToast("Copied to clipboard");
  }

  @override
  Widget build(BuildContext context) {
    final groupService = getProvider<GroupProvider>(context,listen: true);
    final group = groupService.getCurrentGroup();
    final user = getProvider<UserProvider>(context).user;
    return Scaffold(
        floatingActionButton: ElevatedButton.icon(
          onPressed: () async {
            AddGroupTransactionDialog(context).show();
          },
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 25,
              ),
              backgroundColor: const Color(0xff223146),
              foregroundColor: Colors.white,
              shadowColor: Colors.blueAccent,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              )),
          icon: const Text("Add"),
          label: const Icon(
            Icons.add_circle,
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Padding(
                padding: EdgeInsets.only(
                  top: SizeConfig.screenHeight * 0.05,
                  bottom: SizeConfig.screenHeight * 0.05,
                ),
                child: Image.asset(
                  "assets/SplittrLogo.png",
                  width: SizeConfig.screenHeight * 0.2,
                )),
            Card(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              color: const Color(0xff223146),
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                splashColor: Colors.blueAccent,
                onTap: () async {
                  await groupDetails(context, group);
                  debugPrint('Open POP UP');
                },
                child: SizedBox(
                  height: SizeConfig.screenHeight / 6,
                  width: SizeConfig.screenWidth - 50,
                  child: Padding(
                      padding: EdgeInsets.only(
                        top: SizeConfig.screenHeight * 0.02,
                        left: SizeConfig.screenWidth * 0.07,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            group.groupName,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 25),
                          ),
                          Text(
                            '${group.members.length.toString()} Members',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: SizeConfig.screenWidth * 0.02,
                            ),
                            child: TextButton(
                              // <-- TextButton
                              onPressed: () {
                                _copyToClipboard(group.link.toString());
                              },

                              style: ButtonStyle(
                                foregroundColor: MaterialStateProperty.all(
                                    const Color(0xff1870B5)),
                              ),
                              child: const Text(
                                'Copy Link',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          )
                        ],
                      )),
                ),
              ),
            ),
              Text('Group Total : ${group.totalAmount.toString()}'),
              Text('Your Share : ${calcShare()}'),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: group.members.length,
                  //user data toh empty hai bc // nahi h khali ab mc
                  itemBuilder: (context, index) {
                    return Card(
                      child: Text(group.members[index].name.toString()),
                    );
                  }),

            // Row(
            //     children: [
            //   Expanded(
            //       child: GroupDetailsDropdown(
            //         group: group,
            //       )
            //     )
            //   ]
            // ),
              Text("You are ${user.name}"),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: Color(0xff223146),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text('See Settelment'),
              ),
              const Divider(
                color: Colors.black,
                indent: 50,
                endIndent: 50,
                thickness: 2,
              ),
              ListView.builder(
                  itemCount: group.transactions.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    // return TransactionItem(transItem: group.transactions[index]);
                    return Text('        ${group.transactions[index].amount.toString()}');
                  }),
          ],
        )));
  }

  calcShare() {
    return 'Hello';
  }
}
