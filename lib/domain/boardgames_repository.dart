import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gremio_de_historias/presentation/models/lent_game_screen/board_game.dart';

class BoardgamesRepository{

  //Metodo para devolver un juego
  Future<void> returnBorrowedGame(BoardGame boardGame) async{
   FirebaseFirestore db = FirebaseFirestore.instance;
   await db.collection("boardgames").doc(boardGame.id).set(boardGame.toJson());
  }

  //Metodo para obtener los juegos que tengo prestados
  Future<List<BoardGame>> getBorrowedBoardGames(String memberName) async{
    FirebaseFirestore db = FirebaseFirestore.instance;
    List<BoardGame> boardgames = [];
    
    QuerySnapshot querySnapshot = await db.collection("boardgames").where("takenBy", isEqualTo: memberName).get();
    querySnapshot.docs.forEach((element) {
      //Obtenemos el mapa de los datos
      Map<String, dynamic> data_boardgames = element.data() as Map<String, dynamic>;

      //Añadimos el id del documento
      data_boardgames["id"] = element.id;

      //Añadimos el juego a la coleccion de juegos de mesa
      boardgames.add(BoardGame.fromJson(data_boardgames));
    });
    
    return boardgames;
  }
  
  //Metodo para prestar juegos
  Future<void> setBorrowedGames(List<BoardGame> borrowedGames) async{
    FirebaseFirestore db = FirebaseFirestore.instance;

    borrowedGames.forEach((boardgame) async {
      await db.collection("boardgames").doc(boardgame.id).set(boardgame.toJson());
    });
  }

  //Metodo para obtener todos los juegos de mesa de la BD
  Future<List<BoardGame>> getBoardGames() async{
    FirebaseFirestore db = FirebaseFirestore.instance;
    List<BoardGame> boardgames = [];

    QuerySnapshot querySnapshot = await db.collection("boardgames").get();
    querySnapshot.docs.forEach((element) {
      //Obtenemos el mapa de los datos
      Map<String, dynamic> data_boardgames = element.data() as Map<String, dynamic>;

      //Añadimos el id del documento
      data_boardgames["id"] = element.id;

      //Añadimos el juego a la coleccion de juegos de mesa
      boardgames.add(BoardGame.fromJson(data_boardgames));
    });

    return boardgames;
  }

}