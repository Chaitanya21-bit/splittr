class Person {
  late String name;
  late String uid;
  late String alias;
  late String email;
  late String phoneNo;
  late double? limit;
  late List<String> userGroups;

  Person(
      {required this.name,
      required this.uid,
      required this.alias,
      required this.email,
      required this.phoneNo,
      this.limit = -1,
      required this.userGroups,
      }
      );

  static Person fromJson(Map<String, dynamic> json) {
    return Person(
        name: json['name'],
        uid: json['uid'],
        alias: json['alias'],
        email: json['email'],
        phoneNo: json['phoneNo'],
        limit: double.parse(json['limit'].toString()),
        userGroups: List.of(json['userGroups'].cast<String>()),
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'uid': uid,
        'alias': alias,
        'email': email,
        'phoneNo': phoneNo,
        'limit': limit,
        'userGroups': userGroups
      };
}
