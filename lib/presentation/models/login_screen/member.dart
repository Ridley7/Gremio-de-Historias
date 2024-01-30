class Member{
  String name;
  String password;
  int level_access;

  Member({
    required this.name,
    required this.password,
    required this.level_access
  });

  factory Member.fromJson(Map<String, dynamic> json){
    return Member(
        name: json["name"],
        password: json["password"],
        level_access: json["level_access"]
    );
  }
}