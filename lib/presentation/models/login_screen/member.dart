class Member{
  String name;
  String password;
  String role;

  Member({
    required this.name,
    required this.password,
    required this.role
  });

  factory Member.fromJson(Map<String, dynamic> json){
    return Member(
        name: json["name"],
        password: json["password"],
        role: json["role"]
    );
  }
}