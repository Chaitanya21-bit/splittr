import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:splitter/dataclass/group.dart';
import 'package:splitter/services/group_service.dart';

import '../../constants/routes.dart';
import '../../utils/get_provider.dart';

class GroupCard extends StatelessWidget {
  const GroupCard({Key? key, required this.group, required this.index}) : super(key: key);
  final Group group;
  final int index;

  Future<void> _copyToClipboard() async {
    await Clipboard.setData(ClipboardData(text: group.link.toString()));
    Fluttertoast.showToast(msg: "Copied to clipboard");
  }

  @override
  Widget build(BuildContext context) {

    final groupService = getProvider<GroupService>(context);

    return SizedBox(
      width: 200,
      child: Dismissible(
        key: Key(group.gid),
        background: const Align(
          alignment: Alignment.bottomCenter,
          child: Icon(
            Icons.delete,
            color: Colors.black26,
            size: 30.0,
          ),
        ),

        direction: DismissDirection.up,
        onDismissed: (direction) async {
          // await Provider.of<Person>(context, listen: false)
          //     .deleteGroup(widget.group);
        },
        confirmDismiss: (DismissDirection direction) async {
          return await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Confirm"),
                content:
                const Text("Are you sure you wish to delete this group?"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text("CANCEL"),
                  ),
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: const Text("DELETE")),
                ],
              );
            },
          );
        },
        child: Card(
          color: Colors.teal[400],
          margin: const EdgeInsets.all(6),
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(15.0),
            onTap: ()  {
              groupService.setCurrentGroup(index);
              Navigator.pushNamed(context, Routes.grpDash);
            },
            child: Column(
              children: [
                Expanded(
                  flex: 0,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 15,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple[800],
                      border: Border.all(
                        // color: Theme.of(context).primaryColor,
                        color: Colors.limeAccent,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      group.groupName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'Members : ${group.members.length}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple[800],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                    // Text(group.link.toString(),
                    //     );
                    TextButton.icon(     // <-- TextButton
                      onPressed: () {_copyToClipboard();},
                      label: Text(group.link.toString()),
                      icon: const Icon(
                        Icons.copy,
                        size: 24.0,
                      ),
                      style: ButtonStyle(
                        foregroundColor:
                        MaterialStateProperty.all(const Color(0xff1870B5)),
                      ),
                    ),

                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

