class BoardGame{
  //String id;
  String name;
  bool taken;
  String takenBy;
  String urlImage;
  String amountPlayers;
  String age;
  String observations;
  String duration;

  BoardGame({
    //required this.id,
    required this.name,
    required this.taken,
    required this.takenBy,
    required this.urlImage,
    required this.amountPlayers,
    required this.age,
    required this.observations,
    required this.duration
  });

  factory BoardGame.fromJson(Map<String, dynamic> json) {
    return BoardGame(
     // id: json["id"],
        name: json["name"],
        taken: json["taken"],
        takenBy: json["takenBy"],
        urlImage: json["urlImage"],
        amountPlayers: json["amountPlayers"],
        age: json["age"],
        observations: json["observations"],
        duration: json["duration"]
    );
  }
}