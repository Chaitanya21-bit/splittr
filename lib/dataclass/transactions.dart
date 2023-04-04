import 'package:splitter/dataclass/person.dart';

class Transactions {
  late String tid;
  late String title;
  late double amount;
  late String date;
  late String remarks;
  List<Person> split = [];
  late String category;
  late String authorId;
  late bool isGroup = false;

  Transactions(
      {required this.tid,
      required this.title,
      required this.amount,
      required this.date,
      required this.remarks,
      required this.split,
      required this.category,
      required this.authorId,
      required this.isGroup});

  static Future<Transactions> fromJson(Map<String, dynamic> json) async {
    List personList = json['split'] ?? [];
    List<Person> personListFinal = [];

    for(String personUid in personList){
      Person person = Person();
      await person.retrieveBasicInfo(personUid);
      personListFinal.add(person);
    }

    return Transactions(
        tid: json['tid'],
        title: json['title'],
        amount: double.parse(json['amount'].toString()),
        date: json['date'],
        remarks: json['remarks'],
        split: personListFinal,
        category: json['category'],
        authorId: json['authorId'],
        isGroup: json['isGroup']
    );
  }

  Map<String, dynamic> toJson() => {
        'tid': tid,
        'title': title,
        'amount': amount,
        'date': date,
        'remarks': remarks,
        'split': List<String>.generate(
            split.length, (index) => split[index].uid),
        'category': category,
        'authorId': authorId,
        'isGroup': isGroup,
      };
}
