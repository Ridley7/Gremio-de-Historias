class BoardGame{
  String id;
  String name;
  bool taken;
  String takenBy;
  String urlImage;
  String amountPlayers;
  String age;
  String observations;
  String duration;
  List<String> oldUsers;

  BoardGame({
    required this.id,
    required this.name,
    required this.taken,
    required this.takenBy,
    required this.urlImage,
    required this.amountPlayers,
    required this.age,
    required this.observations,
    required this.duration,
    required this.oldUsers
  });

  factory BoardGame.fromJson(Map<String, dynamic> json) {
    return BoardGame(
        id: json["id"],
        name: json["name"],
        taken: json["taken"],
        takenBy: json["takenBy"],
        urlImage: json["urlImage"],
        amountPlayers: json["amountPlayers"],
        age: json["age"],
        observations: json["observations"],
        duration: json["duration"],
      oldUsers: List<String>.from(json['oldUsers']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      //Aqui me interesa sacar el id
      "name": name,
      "taken": taken,
      "takenBy": takenBy,
      "urlImage": urlImage,
      "amountPlayers": amountPlayers,
      "age": age,
      "observations": observations,
      "duration": duration,
      "oldUsers": oldUsers
    };
  }


}