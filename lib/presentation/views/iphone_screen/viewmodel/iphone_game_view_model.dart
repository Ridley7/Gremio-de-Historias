import 'dart:async';

import 'package:gremio_de_historias/domain/boardgames_repository.dart';
import 'package:gremio_de_historias/models/lent_game_screen/board_game.dart';
import 'package:gremio_de_historias/presentation/base/base_view_model.dart';
import 'package:gremio_de_historias/models/resource_state.dart';

class IPhoneGameViewModel extends BaseViewModel {
  final BoardgameRepository _boardgamesRepository;
  final StreamController<ResourceState<List<BoardGame>>>
      getIphoneBoardGameState = StreamController();
  final StreamController<ResourceState<List<BoardGame>>>
      getIphoneBorrowedBoardGameState = StreamController();
  final StreamController<ResourceState<void>> setIphoneBorrowedGamesState =
      StreamController();

  IPhoneGameViewModel({
    required BoardgameRepository boardgamesRepository
  }) : _boardgamesRepository = boardgamesRepository;


  putBorrowedGames(List<BoardGame> borrowedGames) {
    setIphoneBorrowedGamesState.add(ResourceState.loading());

    _boardgamesRepository
        .setBorrowedGames(borrowedGames)
        .then((value) =>
            setIphoneBorrowedGamesState.add(ResourceState.success(value)))
        .catchError((error) =>
            setIphoneBorrowedGamesState.add(ResourceState.error(error)));
  }

  fetchBorrowedBoardGames(String memberName) {
    getIphoneBorrowedBoardGameState.add(ResourceState.loading());

    _boardgamesRepository
        .getBorrowedBoardGames(memberName)
        .then((value) =>
            getIphoneBorrowedBoardGameState.add(ResourceState.success(value)))
        .catchError((error) =>
            getIphoneBorrowedBoardGameState.add(ResourceState.error(error)));
  }

  fetchBoardGames() {
    getIphoneBoardGameState.add(ResourceState.loading());

    _boardgamesRepository
        .getBoardGames()
        .then((value) =>
            getIphoneBoardGameState.add(ResourceState.success(value)))
        .catchError(
            (error) => getIphoneBoardGameState.add(ResourceState.error(error)));
  }

  @override
  void dispose() {
    getIphoneBoardGameState.close();
    getIphoneBorrowedBoardGameState.close();
    setIphoneBorrowedGamesState.close();
  }
}
