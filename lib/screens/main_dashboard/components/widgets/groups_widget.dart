import 'package:flutter/material.dart';
import 'package:splitter/providers/group_provider.dart';
import 'package:splitter/utils/get_provider.dart';

import '../../../../components/cards/group_card.dart';
import '../../../../dataclass/dataclass.dart';

class GroupsWidget extends StatelessWidget {
  const GroupsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final groupProvider = getProvider<GroupProvider>(context, listen: true);
    if (groupProvider.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return groupProvider.groups.isEmpty
        ? const EmptyGroups()
        : GroupsListView(groupsList: groupProvider.groups);
  }
}

class GroupsListView extends StatelessWidget {
  const GroupsListView({
    super.key,
    required this.groupsList,
  });

  final List<Group> groupsList;

  @override
  Widget build(BuildContext context) {
    final itemCount = groupsList.length;
    return ListView.builder(
        itemCount: itemCount,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GroupCard(
            group: groupsList[itemCount-index-1],
            index: itemCount-index-1,
          );
        });
  }
}

class EmptyGroups extends StatelessWidget {
  const EmptyGroups({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            "Welcome to Splittr",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30.0,
              color: Colors.grey[700],
            ),
          ),
        ),
      ),
      Expanded(
        flex: 2,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            "Since you are not in any group, you can select either to join or create a group.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.grey[500],
            ),
          ),
        ),
      ),
    ]);
  }
}
