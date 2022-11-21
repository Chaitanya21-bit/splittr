import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitter/dataclass/group.dart';
import 'package:splitter/dataclass/person.dart';
import 'package:splitter/screens/group_screens/group_dashboard.dart';
import 'package:splitter/route_generator.dart';

class GroupItem extends StatelessWidget {
  const GroupItem({super.key, required this.groupItem});
  final Group groupItem;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Card(
        color: Colors.teal[400],
        margin: const EdgeInsets.all(6),
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        child: Dismissible(
          key: Key(groupItem.gid),
          background: Container(
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(18),
            ),
            // padding: EdgeInsets.only(right: 20.0),
            child: const Align(
              alignment: Alignment.bottomCenter,
              child: Icon(
                Icons.delete,
                color: Colors.white,
                size: 30.0,
              ),
            ),
          ),
          direction: DismissDirection.up,
          onDismissed: (direction) async {
            await Provider.of<Person>(context, listen: false)
                .deleteGroup(groupItem);
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
          child: InkWell(
            borderRadius: BorderRadius.circular(15.0),
            onTap: () => {
              Navigator.pushNamed(context, '/grpDash', arguments: groupItem)
            },
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
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
                        groupItem.groupName,
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
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(padding: EdgeInsets.only(top: 4.0)),
                    Text(
                      'Members : ${groupItem.members.length}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple[800],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(padding: EdgeInsets.only(bottom: 15.0)),
                    Text(groupItem.groupCode,
                        style: const TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 18,
                          color: Colors.limeAccent,
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
