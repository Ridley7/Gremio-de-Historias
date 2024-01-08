import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gremio_de_historias/presentation/models/lent_game_screen/board_game.dart';

class BoardgamesRepository{

  Future<List<BoardGame>> getBoardGames() async{
    FirebaseFirestore db = FirebaseFirestore.instance;
    final data = await db.collection("boardgames").get();

    List<BoardGame> boardgames = data.docs.map((boardgame) => BoardGame.fromJson(boardgame.data())).toList();
    return boardgames;
  }

}