import 'package:flutter/material.dart';
import '../group_screens/group_dashboard.dart';

Future<void> newGroup(BuildContext context) async{
  return await showDialog(context: context,
      builder: (context){
        final TextEditingController groupNameController = TextEditingController();
        final TextEditingController aboutGroupController = TextEditingController();
        final TextEditingController groupLimitController = TextEditingController();
        final TextEditingController personalLimitController = TextEditingController();

        return AlertDialog(
          scrollable: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))
          ),
          title: const Center(child: Text('New Group'),),
          content: Form(

              child: Column(

                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 20,
                  ),

                  TextFormField(
                    controller:groupNameController ,

                    decoration: const InputDecoration(
                      labelText: 'Group Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(

                    controller:aboutGroupController ,
                    decoration: const InputDecoration(
                      labelText: 'About',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(children:  [
                    Expanded(
                      child: TextFormField(
                        controller:groupLimitController ,
                        decoration: const InputDecoration(
                          labelText: 'Group Limit',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller:personalLimitController ,
                        decoration: const InputDecoration(
                          labelText: 'Personal Limit',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ]),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Generated Code',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              )
          ),
          actions: <Widget>[

            ElevatedButton(
              onPressed: () => {Navigator.of(context).pop()},
              style: ButtonStyle(
                // backgroundColor: MaterialStateProperty.all<Color>(Color(0xff42a5f5)),
                backgroundColor: MaterialStateProperty.all(const Color(0xff1870B5)),
                overlayColor: MaterialStateProperty.all<Color>(Colors.pink),
              ),
              child: const Text("Cancel"),
            ),


            ElevatedButton(
              onPressed: () => {
                Navigator.of(context).push(
                    MaterialPageRoute( builder: (context) => const GroupDashboard()))},
              style: ButtonStyle(
                // backgroundColor: MaterialStateProperty.all<Color>(Color(0xff42a5f5)),
                backgroundColor: MaterialStateProperty.all(const Color(0xff1870B5)),
                overlayColor: MaterialStateProperty.all<Color>(Colors.pink),
              ),
              child: const Text("Done"),
            ),
          ],
        );
      });

}