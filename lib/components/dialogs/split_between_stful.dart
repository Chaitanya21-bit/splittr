//Stateful for Radio Button


import 'package:flutter/material.dart';
import 'package:splitter/providers/providers.dart';
import 'package:splitter/utils/size_config.dart';
import 'package:flutter/cupertino.dart';

import '../../dataclass/dataclass.dart';
import '../../utils/get_provider.dart';
import '../cards/set_split_card.dart';

class SplitBetweenDialogSTFUL extends StatefulWidget{

  late final BuildContext context;
  late double amount;

  late final GroupProvider _groupProvider;
  late final Group _group;


  SplitBetweenDialogSTFUL(this.context,{super.key, required this.amount}) {
    _initProviders();
    print("Constructor");
  }

  void _initProviders() {
    _groupProvider = getProvider<GroupProvider>(context);
    _group = _groupProvider.getCurrentGroup();
  }
  @override
  State<SplitBetweenDialogSTFUL> createState() => _SplitBetweenDialogSTFULState();
}

class _SplitBetweenDialogSTFULState extends State<SplitBetweenDialogSTFUL> {
  int customEditValue = 1;

  //NOT GOING IN BUILD FUNCTION
  @override
  Widget build(BuildContext context) {
    print("Build");
    return show();
  }

  _exit() {
    Navigator.pop(widget.context);
  }

  void _RadioChanged(int? value) {
    setState(() {
      customEditValue = value!;
    });
  }

  show() {
    return showDialog(
      context: widget.context,
      builder: (context) {
        return AlertDialog(
          scrollable: true,
          contentPadding: EdgeInsets.zero,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))
          ),
          title: const Center(
            child: Text('Split Between',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          content: Container(
            height: SizeConfig.screenHeight /1.5,
            child: Form(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(widget._group.groupName),
                    ),
                    Text(widget.amount.toString()),
                    RadioListTile(
                      title: Text('Split Evenly'),
                      value: 0,
                      groupValue: customEditValue,
                      onChanged: _RadioChanged,
                    ),
                    const Divider(
                      color: Colors.black,
                      height: 1,
                    ),
                    RadioListTile(
                      title: Text('Custom Split'),
                      value: 1,
                      groupValue: customEditValue,
                      onChanged: _RadioChanged,
                    ),


                    //Make this whole as new File stful & pass members, amount to calc split and then call card
                    //Uss file mai calc karne se constraint daalna easy hoga & card mai calc nai karna padega

                    SizedBox(
                      height: 300,
                      width: 300,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: widget._group.members.length,
                          itemBuilder: (context, index) {
                            return SetSplitCard(
                              memberName: widget._group.members[index].name.toString(),
                              amount : widget.amount,
                              length : widget._group.members.length,
                            );
                          }),
                    ),
                    TextButton(onPressed: (){}, child: Text("Fill Rest Evenly")),
                  ],
                )
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: _exit,
              style: ButtonStyle(
                backgroundColor:
                MaterialStateProperty.all(const Color(0xff1870B5)),
                overlayColor: MaterialStateProperty.all<Color>(Colors.pink),
              ),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: _exit,
              style: ButtonStyle(
                backgroundColor:
                MaterialStateProperty.all(const Color(0xff1870B5)),
                overlayColor: MaterialStateProperty.all<Color>(Colors.pink),
              ),
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

}
