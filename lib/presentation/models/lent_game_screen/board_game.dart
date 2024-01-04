class BoardGame{
  String name;
  bool taken;
  String takenBy;
  String urlImage;
  String amountPlayers;
  String age;
  String observations;
  String duration;

  BoardGame({
    required this.name,
    required this.taken,
    required this.takenBy,
    required this.urlImage,
    required this.amountPlayers,
    required this.age,
    required this.observations,
    required this.duration
  });
}