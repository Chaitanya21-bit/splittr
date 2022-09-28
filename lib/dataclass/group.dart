class Group {
  late String groupName;
  late String gid;
  late String groupCode;
  late double? group_limit;
  late List<String> members;
  late List<dynamic> member_colors = [];
  late List<dynamic> transaction = [];

  Group(
      {
        required this.groupName,
        required this.gid,
        required this.groupCode,
        this.group_limit = -1,
        required this.members,
      }
  );

  static Group fromJson(Map<String, dynamic> json) {
    return Group(
      groupName: json['groupName'],
      gid: json['gid'],
      groupCode: json['groupCode'],
      group_limit: json['group_limit'],
      members : json['members'],
    );
  }

  Map<String, dynamic> toJson() => {
    'groupName': groupName,
    'gid': gid,
    'groupCode':groupCode,
    'group_limit': group_limit,
    'members' : members
  };
}
