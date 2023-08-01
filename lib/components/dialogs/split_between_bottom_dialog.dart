import 'package:flutter/material.dart';
import 'package:splitter/constants/colors.dart';
import '../../dataclass/dataclass.dart';
import '../../providers/providers.dart';
import '../../utils/size_config.dart';
import '../../utils/get_provider.dart';
import '../cards/set_split_card.dart';



splitBottomSheetDialog(BuildContext context, {required double amount, required String title}){

  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) {
      return BottomDialogContent(context,amount : amount, title: title,);
    },
  );
}


class BottomDialogContent extends StatefulWidget {
  final double amount;
  final String title;
  const BottomDialogContent(BuildContext context, {super.key, required double this.amount,required String this.title});
  @override
  State<BottomDialogContent> createState() => _BottomDialogContentState();
}

class _BottomDialogContentState extends State<BottomDialogContent> {

  late final GroupProvider _groupProvider;
  late final Group _group;

  void _initProviders() {
    _groupProvider = getProvider<GroupProvider>(context);
    _group = _groupProvider.getCurrentGroup();
  }

  @override
  void initState() {
    _initProviders();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.4,
      maxChildSize: 0.8,
      minChildSize: 0.2,
      builder: (_,controller) =>
        Container(
          color: Colors.white,
          child: Form(
              child: ListView(
                controller: controller,
                shrinkWrap: true,
                children: [

                  Container(
                    height: SizeConfig.screenHeight/8,
                    color: AppColors.purple,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Text(widget.title,
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Text("Group : ${_group.groupName}",
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 10,
                                )
                              ),
                              Text(widget.amount.toString(),
                                style: TextStyle(
                                  color: AppColors.white,
                                fontSize: 15)),
                            ],
                          ),

                        ],
                      ),
                    )
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(onPressed: (){}, child: Text("Reset")),
                      TextButton(onPressed: (){}, child: Text("Save")),
                    ],
                  ),

                  Divider(
                    color: Colors.black,
                    height: 1,
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 20,
                    ),
                    child: SizedBox(
                      // height: 100,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: _group.members.length,
                          itemBuilder: (context, index) {
                            return SetSplitCard(
                              memberName: _group.members[index].name.toString(),
                              amount : widget.amount,
                              length : _group.members.length,
                            );
                          }
                          ),
                    ),
                  )
                ],
              )
          ),
        )
    );
  }
}

