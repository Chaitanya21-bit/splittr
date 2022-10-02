import 'package:flutter/material.dart';
import 'package:splitter/screens/group_screens/group_dashboard.dart';

class GroupItem extends StatelessWidget {
  GroupItem({required this.groupItem, required this.deleteGroup});
  final dynamic groupItem;
  final Function deleteGroup;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      // height: MediaQuery.of(context).size.height * 0.30 - 50,
      child: Card(
        color: Colors.teal[400],
        margin: EdgeInsets.all(6),
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        child: Dismissible(
          key: Key(groupItem['gid']),
          background: Container(
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(18),
            ),
            // padding: EdgeInsets.only(right: 20.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Icon(
                Icons.delete,
                color: Colors.white,
                size: 30.0,
              ),
            ),
          ),
          direction: DismissDirection.up,
          onDismissed: (direction) {
            deleteGroup(context, groupItem['gid']);
          },
          confirmDismiss: (DismissDirection direction) async {
            return await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Confirm"),
                  content: Text("Are you sure you wish to delete this group?"),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text("CANCEL"),
                    ),
                    TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: Text("DELETE")),
                  ],
                );
              },
            );
          },
          child: InkWell(
            borderRadius: BorderRadius.circular(15.0),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GroupDashboard(),
                ),
              );
            },
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.symmetric(
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
                        groupItem['groupName'],
                        style: TextStyle(
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
                    Padding(padding: EdgeInsets.only(top: 4.0)),
                    Text(
                      'Members : ${groupItem['members'].length}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple[800],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(padding: EdgeInsets.only(bottom: 15.0)),
                    Text(groupItem['groupCode'],
                        style: TextStyle(
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
    // return Container(
    //   width: 200,
    //   margin: EdgeInsets.only(right: 20),
    //   height: MediaQuery.of(context).size.height * 0.30 - 50,
    //   decoration: BoxDecoration(
    //       color: Colors.tealAccent,
    //       borderRadius: BorderRadius.all(Radius.circular(20.0))),
    //   child: Padding(
    //     padding: const EdgeInsets.all(12.0),
    //     child: Center(child: Text(txt, style: TextStyle(fontSize: 20))),
    //   ),
    // );
  }
}
