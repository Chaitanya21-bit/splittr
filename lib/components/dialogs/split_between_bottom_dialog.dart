import 'package:flutter/material.dart';
import 'package:splitter/constants/colors.dart';
import 'package:splitter/dataclass/even_split_users_model.dart';

import '../../dataclass/dataclass.dart';
import '../../providers/providers.dart';
import '../../screens/base.dart';
import '../../utils/get_provider.dart';
import '../../utils/size_config.dart';

class SplitBetweenBottomDialogScreen extends StatefulWidget {
  const SplitBetweenBottomDialogScreen(
      {super.key,
      required this.amount,
      required this.title,
      required this.evenSplit,
      required this.oddMap});

  final double amount;
  final String title;
  final EvenSplitUsersModel evenSplit;
  final Map<String, dynamic> oddMap;

  @override
  State<SplitBetweenBottomDialogScreen> createState() =>
      _SplitBetweenBottomDialogScreenState();
}

class _SplitBetweenBottomDialogScreenState
    extends State<SplitBetweenBottomDialogScreen> {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.4,
      maxChildSize: 0.8,
      minChildSize: 0.2,
      builder: (_, controller) => BaseView<SplitBetweenBottomDialogController>(
        controller: SplitBetweenBottomDialogController(
          context: context,
          title: widget.title,
          totalAmount: widget.amount,
          evenSplitUsers: widget.evenSplit,
          constantSplitUsers: widget.oddMap,
        ),
        builder: (context, screenController, _) => Container(
          color: Colors.white,
          child: Form(
            child: ListView(
              controller: controller,
              shrinkWrap: true,
              children: [
                Container(
                    height: SizeConfig.screenHeight / 8,
                    color: AppColors.purple,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.title,
                            style: const TextStyle(
                              color: AppColors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Group : ${screenController.groupName}",
                                  style: const TextStyle(
                                    color: AppColors.white,
                                    fontSize: 10,
                                  )),
                              Text(widget.amount.toString(),
                                  style: const TextStyle(
                                      color: AppColors.white, fontSize: 15)),
                            ],
                          ),
                        ],
                      ),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(onPressed: () {}, child: const Text("Reset")),
                    TextButton(onPressed: () {}, child: const Text("Save")),
                  ],
                ),
                const Divider(
                  color: Colors.black,
                  height: 1,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                  ),
                  child: SizedBox(
                    // height: 100,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: screenController.groupMembers.length,
                      itemBuilder: (context, index) {
                        final user = screenController.groupMembers[index];
                        final uid = user.uid;
                        return TempCard(
                          name: user.name,
                          isSelected: screenController.isInConstantSplit(uid) ||
                              screenController.isInEvenSplit(uid),
                          isEven: screenController.isInEvenSplit(uid),
                          controller: screenController.textEditingControllers[index],
                          shareAmount:
                              screenController.individualShareAmount(uid),
                          onCheckBoxChange: (addToSplit) {
                            screenController.onCheckBoxChanged(addToSplit, uid,index);
                          },
                          onTextFieldChange: (val) => screenController
                              .onConstantAmountChange(val!, uid,index),
                          onEvenOrConstant: () =>
                              screenController.onEvenOrConstant(uid,index),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TempCard extends StatelessWidget {
  const TempCard({
    super.key,
    required this.name,
    required this.isSelected,
    required this.shareAmount,
    required this.onCheckBoxChange,
    required this.onTextFieldChange,
    required this.isEven,
    required this.onEvenOrConstant, required this.controller,
  });

  final String name;
  final bool isSelected;
  final bool isEven;
  final double? shareAmount;
  final Function(bool?) onCheckBoxChange;
  final Function(String?) onTextFieldChange;
  final VoidCallback onEvenOrConstant;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Checkbox(value: isSelected, onChanged: onCheckBoxChange),
          Text(name),
          SizedBox(
            width: 50,
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: controller,
              onChanged: onTextFieldChange,
              readOnly: isEven,
              decoration: const InputDecoration(
                // icon: Icon(Icons.currency_rupee),
                // border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 2, vertical: 0),
              ),
            ),
          ),
          if (isSelected)
            TextButton(
              onPressed: onEvenOrConstant,
              child: Text(isEven ? "Even" : "Constant"),
            ),
        ],
      ),
    );
  }
}

class SplitBetweenBottomDialogController extends ChangeNotifier {
  late final GroupProvider _groupProvider;
  late final Group _group;
  final double totalAmount;
  final EvenSplitUsersModel evenSplitUsers;
  final Map<String, dynamic> constantSplitUsers;
  final String title;
  final BuildContext context;
  final List<TextEditingController> textEditingControllers = [];

  int get evenNoOfPeople => evenSplitUsers.users.length;

  double get evenAmount => evenSplitUsers.amount;

  String get groupName => _group.groupName;

  List<User> get groupMembers => _group.members;

  SplitBetweenBottomDialogController({
    required this.context,
    required this.title,
    required this.totalAmount,
    required this.evenSplitUsers,
    required this.constantSplitUsers,
  }) {
    _initProviders();
  }

  void _initProviders() {
    _groupProvider = getProvider<GroupProvider>(context);
    _group = _groupProvider.getCurrentGroup();
    textEditingControllers.addAll(_group.members.map((e) => TextEditingController()));
  }

  bool isInEvenSplit(String uid) {
    return evenSplitUsers.users.contains(uid);
  }

  bool isInConstantSplit(String uid) {
    return constantSplitUsers[uid] != null;
  }

  double? individualShareAmount(String uid) {
    if (isInEvenSplit(uid)) {
      return evenAmount / evenNoOfPeople;
    }
    if (isInConstantSplit(uid)) {
      return constantSplitUsers[uid];
    }
    return null;
  }

  void onCheckBoxChanged(bool? addToSplit, String uid,int index) {
    if (addToSplit == true) {
      evenSplitUsers.users.add(uid);
    } else {
      if (isInEvenSplit(uid)) {
        evenSplitUsers.users.remove(uid);
      } else {
        final currentAmount = individualShareAmount(uid);
        evenSplitUsers.amount += currentAmount!;
        constantSplitUsers.remove(uid);
      }
    }
    updateTextEditingController(index, uid);

    notifyListeners();
  }

  void updateTextEditingController(int index, String uid,
      {bool updateCurrent = true}){
    for(int i= 0;i < textEditingControllers.length ; i++){
      if(i == index && !updateCurrent){
        continue;
      }
      textEditingControllers[i].text = (individualShareAmount(_group.members[i].uid) ?? "").toString();
    }
  }

  void onConstantAmountChange(String amount, String uid,int index) {
    if (isInEvenSplit(uid) || amount.isEmpty || amount.startsWith('.') || amount.endsWith('.')) return;
    final currentAmount = individualShareAmount(uid)!;
    final newAmount = double.parse(amount);
    constantSplitUsers[uid] -= currentAmount - newAmount;
    evenSplitUsers.amount += currentAmount - newAmount;
    updateTextEditingController(index, uid,updateCurrent: false);
    notifyListeners();
  }

  void onEvenOrConstant(String uid,int index) {
    if (isInEvenSplit(uid)) {
      final currentShare = individualShareAmount(uid);
      evenSplitUsers.users.remove(uid);
      constantSplitUsers[uid] = currentShare;
      evenSplitUsers.amount -= currentShare!;
    } else {
      final currentShare = individualShareAmount(uid);
      evenSplitUsers.users.add(uid);
      constantSplitUsers.remove(uid);
      evenSplitUsers.amount += currentShare!;
    }
    updateTextEditingController(index, uid);
    notifyListeners();
  }
}
