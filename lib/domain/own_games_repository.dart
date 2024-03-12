import 'package:gremio_de_historias/models/lent_game_screen/board_game.dart';

abstract class OwnGamesRepository{
  //Metodo para devolver un juego
  Future<void> returnBorrowedGame(BoardGame boardGame);
  //Metodo para obtener los juegos que tengo prestados
  Future<List<BoardGame>> getBorrowedBoardGames(String memberName);
}
