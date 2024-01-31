import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gremio_de_historias/presentation/models/lent_game_screen/board_game.dart';

class BoardgamesRepository{

  //Metodo para prestar juegos
  Future<void> setBorrowedGames(List<BoardGame> borrowedGames) async{
    FirebaseFirestore db = FirebaseFirestore.instance;

    //ME FALTA EL ID DEL DOCUMENTO QUE SE TIENE QUE AÑADIR EN EL METODO DE ABAJO

  }

  //Metodo para obtener todos los juegos de mesa de la BD
  Future<List<BoardGame>> getBoardGames() async{
    FirebaseFirestore db = FirebaseFirestore.instance;
    final data = await db.collection("boardgames").get();

    List<BoardGame> boardgames = data.docs.map((boardgame) => BoardGame.fromJson(boardgame.data())).toList();
    return boardgames;
  }

}