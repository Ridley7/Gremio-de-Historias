import 'package:gremio_de_historias/models/lent_game_screen/board_game.dart';

abstract class IPhoneGameScreenRepository{

  //Metodo para obtener los juegos que tengo prestados
  Future<List<BoardGame>> getBorrowedBoardGames(String memberName);
  //Metodo para prestar juegos
  Future<void> setBorrowedGames(List<BoardGame> borrowedGames);
  //Metodo para obtener todos los juegos de mesa de la BD
  Future<List<BoardGame>> getBoardGames();

}
