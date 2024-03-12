import 'package:gremio_de_historias/data/iphone_screen/iphone_games_screen_remote_implementation.dart';

import 'package:gremio_de_historias/domain/iphone_game_screen_repository.dart';
import 'package:gremio_de_historias/models/lent_game_screen/board_game.dart';

class IPhoneGamesScreenDataImplementation extends IPhoneGameScreenRepository{

  final IPhoneGamesScreenRemoteImplementation _remoteImplementation;

  IPhoneGamesScreenDataImplementation({
    required IPhoneGamesScreenRemoteImplementation remoteImplementation
  }) : _remoteImplementation = remoteImplementation;

  @override
  Future<List<BoardGame>> getBoardGames() {
    return _remoteImplementation.getBoardGames();
  }

  @override
  Future<List<BoardGame>> getBorrowedBoardGames(String memberName) {
    return _remoteImplementation.getBorrowedBoardGames(memberName);
  }

  @override
  Future<void> setBorrowedGames(List<BoardGame> borrowedGames) {
    return _remoteImplementation.setBorrowedGames(borrowedGames);
  }


}