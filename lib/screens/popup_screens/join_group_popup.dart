
import 'package:flutter/material.dart';

Future<void> joinGroup(BuildContext context) async{
  return await showDialog(context: context,
      builder: (context){
        final TextEditingController joinGroupController = TextEditingController();

        return AlertDialog(
          scrollable: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))
          ),
          title: const Center(child: Text('Join Group'),),
          content: Form(

              child: Column(

                mainAxisSize: MainAxisSize.min,
                children: [
                  const Center(child: Text('Group Name'),),
                  const SizedBox(
                    height: 20,
                  ),

                  const SizedBox(
                    height: 30,
                  ),

                  TextFormField(

                    controller:joinGroupController ,

                    decoration: const InputDecoration(
                      labelText: 'Add Code',
                      border: OutlineInputBorder(),
                    ),

                  ),

                  const SizedBox(
                    height: 30,
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
              onPressed: () => {},
              style: ButtonStyle(
                // backgroundColor: MaterialStateProperty.all<Color>(Color(0xff42a5f5)),
                backgroundColor: MaterialStateProperty.all(const Color(0xff1870B5)),
                overlayColor: MaterialStateProperty.all<Color>(Colors.pink),
              ),
              child: const Text("Join"),
            ),
          ],
        );
      });

}