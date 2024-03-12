import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gremio_de_historias/data/remote/error/remote_error_mapper.dart';
import 'package:gremio_de_historias/data/remote/network_client.dart';
import 'package:gremio_de_historias/models/lent_game_screen/board_game.dart';

class OwnGamesRemoteImplementation{
  final NetworkClient _networkClient;

  OwnGamesRemoteImplementation({
    required NetworkClient networkClient
  }) : _networkClient = networkClient;

  //Metodo para devolver un juego
  Future<void> returnBorrowedGame(BoardGame boardGame) async{
    try{
      await _networkClient.db.collection("boardgames").doc(boardGame.id).set(boardGame.toJson());
    }catch(error){
      throw RemoteErrorMapper.getException(error);
    }
  }

  Future<List<BoardGame>> getBorrowedBoardGames(String memberName) async{
    try{
      List<BoardGame> boardgames = [];

      QuerySnapshot querySnapshot = await _networkClient.db.collection("boardgames").where("takenBy", isEqualTo: memberName).get();
      querySnapshot.docs.forEach((element) {
        //Obtenemos el mapa de los datos
        Map<String, dynamic> data_boardgames = element.data() as Map<String, dynamic>;

        //Añadimos el id del documento
        data_boardgames["id"] = element.id;

        //Añadimos el juego a la coleccion de juegos de mesa
        boardgames.add(BoardGame.fromJson(data_boardgames));
      });

      return boardgames;

    } catch (error){
      throw RemoteErrorMapper.getException(error);
    }
  }

}
