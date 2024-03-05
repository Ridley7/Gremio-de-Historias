import 'dart:async';

import 'package:gremio_de_historias/domain/boardgames_repository.dart';
import 'package:gremio_de_historias/models/lent_game_screen/board_game.dart';
import 'package:gremio_de_historias/presentation/base/base_view_model.dart';
import 'package:gremio_de_historias/models/resource_state.dart';

class DropGameModelView extends BaseViewModel{

  final BoardgamesRepository _boardgamesRepository = BoardgamesRepository();
  final StreamController<ResourceState<List<BoardGame>>> getBorrowedGameBoardState = StreamController();
  final StreamController<ResourceState<void>> setBorrowedGameState = StreamController();

  //Aqui falta un constructor para meter di

  returnBorrowedGame(BoardGame boardGame){
    setBorrowedGameState.add(ResourceState.loading());

    _boardgamesRepository.returnBorrowedGame(boardGame)
    .then((value) => setBorrowedGameState.add(ResourceState.success(value)))
    .catchError((error) => setBorrowedGameState.add(ResourceState.error(error)));
  }

  fetchBorrowedBoardGames(String memberName){
    getBorrowedGameBoardState.add(ResourceState.loading());

    _boardgamesRepository.getBorrowedBoardGames(memberName)
        .then((value) => getBorrowedGameBoardState.add(ResourceState.success(value)))
        .catchError((error) => getBorrowedGameBoardState.add(ResourceState.error(error)));
  }



  @override
  void dispose() {
    getBorrowedGameBoardState.close();
    setBorrowedGameState.close();
  }
}