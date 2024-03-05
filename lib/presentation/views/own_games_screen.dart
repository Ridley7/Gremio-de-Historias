import 'package:flutter/material.dart';
import 'package:gremio_de_historias/models/lent_game_screen/board_game.dart';
import 'package:gremio_de_historias/presentation/model/resource_state.dart';
import 'package:gremio_de_historias/presentation/providers/member_provider.dart';
import 'package:gremio_de_historias/presentation/views/common_model_view/drop_game_view_model.dart';
import 'package:gremio_de_historias/presentation/widgets/commons/card_drop_game.dart';
import 'package:gremio_de_historias/presentation/widgets/commons/error_view.dart';
import 'package:gremio_de_historias/presentation/widgets/commons/overlay_loading_view.dart';
import 'package:provider/provider.dart';

class OwnGamesScreen extends StatefulWidget {
  const OwnGamesScreen({super.key});

  @override
  State<OwnGamesScreen> createState() => _OwnGamesScreenState();
}

class _OwnGamesScreenState extends State<OwnGamesScreen> {

  List<BoardGame> boardGames = [];
  final DropGameModelView _dropGameModelView = DropGameModelView();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    final memberProvider = context.read<MemberProvider>();

    _dropGameModelView.setBorrowedGameState.stream.listen((state) {
      switch(state.status){

        case Status.LOADING:
          OverlayLoadingView.show(context);
          break;
        case Status.SUCCESS:
          OverlayLoadingView.hide();
          setState(() {
            _dropGameModelView.fetchBorrowedBoardGames(memberProvider.getCurrentMember().name);
          });
          break;
        case Status.ERROR:
          OverlayLoadingView.hide();
          ErrorView.show(context, state.exception!.toString(), (){
            print("Error al devolver el juego");
          });
          break;
      }
    });

    _dropGameModelView.getBorrowedGameBoardState.stream.listen((state) {
      switch(state.status){

        case Status.LOADING:
          OverlayLoadingView.show(context);
          break;
        case Status.SUCCESS:
          OverlayLoadingView.hide();
          setState(() {
            boardGames = state.data!;
          });
          break;
        case Status.ERROR:
          OverlayLoadingView.hide();
          ErrorView.show(context, state.exception!.toString(), (){
            print("Error al cargar los juegos prestados en pantalla de iphone");
          });
          break;
      }
    });

    _dropGameModelView.fetchBorrowedBoardGames(memberProvider.getCurrentMember().name);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Juegos prestados"),
        centerTitle: true,
      ),
      body: SafeArea(
        child:
        boardGames.isEmpty
        ? const Center(
          child: Text("No tienes juegos en tu poder para devolver."),
        )
        :
        GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
            ),
            itemCount: boardGames.length,
            itemBuilder: (context, index){
              return CardDropGame(
                  dropGameModelView: _dropGameModelView,
                  boardGame: boardGames[index],
                  index: index
              );
            }
        ),
      ),
    );
  }
}

