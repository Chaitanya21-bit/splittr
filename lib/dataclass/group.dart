import 'package:splitter/dataclass/group_transaction.dart';
import 'package:splitter/dataclass/user.dart';

class Group {
  late String groupName;
  late String gid;
  late String groupDescription;
  late double? groupLimit;
  late List<User> members;
  late List<GroupTransaction> transactions;
  late Uri link;
  late double totalAmount;



  Group(
      {
        required this.groupName,
        required this.gid,
        required this.groupDescription,
        required this.groupLimit,
        required this.link,
        required this.totalAmount,
        required this.members,
        required this.transactions,
      });

  static Group fromJson(Map<String, dynamic> json) => Group(
        groupName: json['groupName'],
        gid: json['gid'],
        groupDescription: json['groupDescription'],
        groupLimit: double.parse(json['groupLimit'].toString()),
        link: Uri.parse(json['link']),
        totalAmount: double.parse(
          json['totalAmount'].toString(),
        ),
        members: json['members'] == null ? [] : (json['members'] as List)
            .map((userJson) => User.basicInfo(userJson))
            .toList(),
        transactions: json['transactions'] == null ? [] :(json['transactions'] as List)
            .map((e) => GroupTransaction.fromJson(e))
            .toList(),

  );

  Map<String, dynamic> toJson() => {
        'groupName': groupName,
        'gid': gid,
        'groupDescription': groupDescription,
        'groupLimit': groupLimit,
        'members': List<String>.generate(
            members.length, (index) => members[index].uid),
        'transactions': List<String>.generate(
            transactions.length, (index) => transactions[index].tid),
        'link': link.toString(),
        'totalAmount': totalAmount,
      };
}
