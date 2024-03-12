import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gremio_de_historias/models/lent_game_screen/board_game.dart';

abstract class BoardgameRepository{
  //Metodo para devolver un juego
  Future<void> returnBorrowedGame(BoardGame boardGame);
  //Metodo para obtener los juegos que tengo prestados
  Future<List<BoardGame>> getBorrowedBoardGames(String memberName);
  //Metodo para prestar juegos
  Future<void> setBorrowedGames(List<BoardGame> borrowedGames);
  //Metodo para obtener todos los juegos de mesa de la BD
  Future<List<BoardGame>> getBoardGames();
}
/*
class BoardgamesRepository{


  
  //Metodo para prestar juegos
  Future<void> setBorrowedGames(List<BoardGame> borrowedGames) async{
    FirebaseFirestore db = FirebaseFirestore.instance;

    borrowedGames.forEach((boardgame) async {
      await db.collection("boardgames").doc(boardgame.id).set(boardgame.toJson());
    });
  }



}

 */