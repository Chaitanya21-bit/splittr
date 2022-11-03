class Group {
  late String groupName;
  late String gid;
  late String groupCode;
  late String groupDescription;
  late double? group_limit;
  late List<String> members;
  late List<dynamic> member_colors = [];
  late List<dynamic> transaction = [];

  Group(
      {
        required this.groupName,
        required this.gid,
        required this.groupCode,
        required this.groupDescription,
        this.group_limit = -1,
        required this.members,
      }
  );

  static Group fromJson(Map<String, dynamic> json) {
    return Group(
      groupName: json['groupName'],
      gid: json['gid'],
      groupCode: json['groupCode'],
      groupDescription : json['groupDescription'],
      group_limit: json['group_limit'],
      members : json['members'],
    );
  }

  Map<String, dynamic> toJson() => {
    'groupName': groupName,
    'gid': gid,
    'groupCode':groupCode,
    'groupDescription':groupDescription,
    'group_limit': group_limit,
    'members' : members
  };
}
