import 'package:gremio_de_historias/data/own_games_screen/own_games_remote_implementation.dart';
import 'package:gremio_de_historias/domain/own_games_repository.dart';
import 'package:gremio_de_historias/models/lent_game_screen/board_game.dart';

class OwnGamesDataImplementation extends OwnGamesRepository{

  final OwnGamesRemoteImplementation _remoteImplementation;

  OwnGamesDataImplementation({
    required OwnGamesRemoteImplementation remoteImplementation
  }) : _remoteImplementation = remoteImplementation;

  @override
  Future<List<BoardGame>> getBorrowedBoardGames(String memberName) {
    return _remoteImplementation.getBorrowedBoardGames(memberName);
  }

  @override
  Future<void> returnBorrowedGame(BoardGame boardGame) {
    return _remoteImplementation.returnBorrowedGame(boardGame);
  }
}
