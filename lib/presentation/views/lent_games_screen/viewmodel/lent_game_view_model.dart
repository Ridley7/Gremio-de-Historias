import 'dart:async';

import 'package:gremio_de_historias/domain/boardgames_repository.dart';
import 'package:gremio_de_historias/models/lent_game_screen/board_game.dart';
import 'package:gremio_de_historias/presentation/base/base_view_model.dart';
import 'package:gremio_de_historias/models/resource_state.dart';

class LentGameViewModel extends BaseViewModel {
  final BoardgamesRepository _boardgamesRepository = BoardgamesRepository();
  final StreamController<ResourceState<List<BoardGame>>> getLentGameState =
      StreamController();
  final StreamController<ResourceState<List<BoardGame>>>
      getBorrowedGameBoardState = StreamController();
  final StreamController<ResourceState<void>> setBorrowedGameState =
      StreamController();

  //Aqui falta un constructor para meter di

  putBorrowedGames(List<BoardGame> borrowedGames) {
    setBorrowedGameState.add(ResourceState.loading());

    _boardgamesRepository
        .setBorrowedGames(borrowedGames)
        .then((value) => setBorrowedGameState.add(ResourceState.success(value)))
        .catchError(
            (error) => setBorrowedGameState.add(ResourceState.error(error)));
  }

  fetchBorrowedBoardGames(String memberName) {
    getBorrowedGameBoardState.add(ResourceState.loading());

    _boardgamesRepository
        .getBorrowedBoardGames(memberName)
        .then((value) =>
            getBorrowedGameBoardState.add(ResourceState.success(value)))
        .catchError((error) =>
            getBorrowedGameBoardState.add(ResourceState.error(error)));
  }

  fetchBoardGames() {
    getLentGameState.add(ResourceState.loading());

    _boardgamesRepository
        .getBoardGames()
        .then((value) => getLentGameState.add(ResourceState.success(value)))
        .catchError(
            (error) => getLentGameState.add(ResourceState.error(error)));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    getLentGameState.close();
    getBorrowedGameBoardState.close();
    setBorrowedGameState.close();
  }
}
