class User {
  String name;
  String uid;
  String alias;
  String email;
  String phoneNo;
  List<String> groups;
  List<String> personalTransactions;
  double limit;


  User(
      {required this.uid,
      required this.name,
      required this.alias,
      required this.email,
      required this.phoneNo,
      required this.groups,
      required this.personalTransactions,
      required this.limit});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json['uid'],
      name: json['name'],
      alias: json['alias'],
      email: json['email'],
      phoneNo: json['phoneNo'],
      groups: json['groups'] == null ? [] : List<String>.from(json['groups']),
      personalTransactions: json['personalTransactions'] == null
          ? []
          : List<String>.from(json['personalTransactions']),
      limit: json['limit']==null?-1:double.parse(json['limit'].toString()),
    );
  }

  static User basicInfo(Map<String, dynamic> json) {
    return User(
        uid: json['uid'],
        name: json['name'],
        alias: json['alias'],
        email: json['email'],
        phoneNo: json['phoneNo'],
        groups: [],
        personalTransactions: [], limit: -1);
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'uid': uid,
        'alias': alias,
        'email': email,
        'phoneNo': phoneNo,
        'limit': limit,
        'groups': groups,
        'personalTransactions': personalTransactions
      };
}
