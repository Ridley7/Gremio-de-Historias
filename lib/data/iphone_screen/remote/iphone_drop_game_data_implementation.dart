import 'package:gremio_de_historias/data/iphone_screen/iphone_drop_game_remote_implementation.dart';
import 'package:gremio_de_historias/domain/boardgames_repository.dart';
import 'package:gremio_de_historias/models/lent_game_screen/board_game.dart';

class IphoneDropGameDataImplementation extends BoardgameRepository{

  final IphoneDropGameRemoteImplementation _remoteImplementation;

  IphoneDropGameDataImplementation({
    required IphoneDropGameRemoteImplementation remoteImplementation
  }) : _remoteImplementation = remoteImplementation;

  @override
  Future<void> returnBorrowedGame(BoardGame boardGame) {
    return _remoteImplementation.returnBorrowedGame(boardGame);
  }

  @override
  Future<List<BoardGame>> getBorrowedBoardGames(String memberName) {
    return _remoteImplementation.getBorrowedBoardGames(memberName);
  }

  @override
  Future<List<BoardGame>> getBoardGames() {
    // TODO: implement getBoardGames
    throw UnimplementedError();
  }

  @override
  Future<void> setBorrowedGames(List<BoardGame> borrowedGames) {
    // TODO: implement setBorrowedGames
    throw UnimplementedError();
  }





}