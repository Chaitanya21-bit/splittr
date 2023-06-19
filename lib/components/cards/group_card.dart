import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:splitter/colors.dart';
import 'package:splitter/dataclass/dataclass.dart';
import 'package:splitter/providers/providers.dart';

import '../../constants/routes.dart';
import '../../utils/get_provider.dart';

class GroupCard extends StatelessWidget {
  const GroupCard({Key? key, required this.group, required this.index})
      : super(key: key);
  final Group group;
  final int index;

  Future<void> _copyToClipboard() async {
    await Clipboard.setData(ClipboardData(text: group.link.toString()));
    Fluttertoast.showToast(msg: "Copied to clipboard");
  }

  @override
  Widget build(BuildContext context) {
    final groupProvider = getProvider<GroupProvider>(context);

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
          color: AppColors().white,
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: InkWell(
            onTap: () {
              groupProvider.setCurrentGroup(index);
              Navigator.pushNamed(context, Routes.grpDash);
            },
            child: Column(
              children: [
                Expanded(
                  flex: 0,
                  child: Padding(padding: EdgeInsets.only(top: 10),
                   child:Text(
                      group.groupName,
                      style: TextStyle(
                        color: AppColors().black,
                        fontSize: 20,
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
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 20,
                    ),
                    child: Text(
                    '${group.members.length} Members',
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors().black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                ),
                Expanded(
                  flex: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child:
                        // group.link.toString(),
                        TextButton.icon(
                          onPressed: () {
                            _copyToClipboard();
                          },
                          label: Text("Copy Link"),
                          icon: const Icon(
                            Icons.copy,
                            size: 24.0,
                          ),
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all(AppColors().purple),
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
