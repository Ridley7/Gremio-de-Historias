import 'package:gremio_de_historias/data/lent_games_screen/lent_games_remote_implementation.dart';
import 'package:gremio_de_historias/domain/boardgames_repository.dart';
import 'package:gremio_de_historias/models/lent_game_screen/board_game.dart';

class LentGamesDataImplementation extends BoardgameRepository{

  final LentGamesRemoteImplementation _remoteImplementation;

  LentGamesDataImplementation({
    required LentGamesRemoteImplementation remoteImplementation
  }) : _remoteImplementation = remoteImplementation;

  @override
  Future<void> setBorrowedGames(List<BoardGame> borrowedGames) {
    return _remoteImplementation.setBorrowedGames(borrowedGames);
  }

  @override
  Future<List<BoardGame>> getBorrowedBoardGames(String memberName) {
    // TODO: implement getBorrowedBoardGames
    return _remoteImplementation.getBorrowedBoardGames(memberName);
  }

  @override
  Future<List<BoardGame>> getBoardGames() {
    // TODO: implement getBoardGames
    return _remoteImplementation.getBoardGames();
  }

  @override
  Future<void> returnBorrowedGame(BoardGame boardGame) {
    // TODO: implement returnBorrowedGame
    throw UnimplementedError();
  }





}