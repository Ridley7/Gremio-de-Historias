import 'package:flutter/material.dart';
import 'package:gremio_de_historias/models/lent_game_screen/board_game.dart';
import 'package:gremio_de_historias/presentation/model/resource_state.dart';
import 'package:gremio_de_historias/presentation/navigation/navigation_routes.dart';
import 'package:gremio_de_historias/presentation/providers/proxy_member_provider.dart';
import 'package:gremio_de_historias/presentation/views/iphone_screen/viewmodel/iphone_game_view_model.dart';
import 'package:gremio_de_historias/presentation/widgets/commons/board_game_list_widget.dart';
import 'package:gremio_de_historias/presentation/widgets/commons/error_view.dart';
import 'package:gremio_de_historias/presentation/widgets/commons/info_view.dart';
import 'package:gremio_de_historias/presentation/widgets/commons/overlay_loading_view.dart';
import 'package:provider/provider.dart';

class IPhoneGameScreen extends StatefulWidget {
  const IPhoneGameScreen({
    super.key,
  });

  @override
  State<IPhoneGameScreen> createState() => _IPhoneGameScreenState();
}

class _IPhoneGameScreenState extends State<IPhoneGameScreen> {
  final IPhoneGameViewModel _iPhoneGameViewModel = IPhoneGameViewModel();
  List<BoardGame> boardGames = [];
  List<bool> checkedList = [];
  DateTime? selectedDate;
  List<BoardGame> listGamesInMyHouse = [];

  late final ProxyMemberProvider proxyMemberProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _iPhoneGameViewModel.setIphoneBorrowedGamesState.stream.listen((state) {
      switch (state.status) {
        case Status.LOADING:
          OverlayLoadingView.show(context);
          break;
        case Status.SUCCESS:
          OverlayLoadingView.hide();
          InfoView.show(context, "Juego retirado correctamente");
          setState(() {
            //Hace falta esto?
            _iPhoneGameViewModel.fetchBoardGames();
          });
          break;
        case Status.ERROR:
          OverlayLoadingView.hide();
          ErrorView.show(context, state.exception!.toString(), () {
            print("Error al guardar los juegos que se prestan");
          });
          break;
      }
    });

    _iPhoneGameViewModel.getIphoneBorrowedBoardGameState.stream.listen((state) {
      switch (state.status) {
        case Status.LOADING:
          OverlayLoadingView.show(context);
          break;
        case Status.SUCCESS:
          OverlayLoadingView.hide();
          setState(() {
            //Hacemos cosas
            listGamesInMyHouse = state.data!;
          });
          break;
        case Status.ERROR:
          OverlayLoadingView.hide();
          ErrorView.show(context, state.exception!.toString(), () {
            print("Error al obtener los juegos en poder del usuario");
          });
          break;
      }
    });

    _iPhoneGameViewModel.getIphoneBoardGameState.stream.listen((state) {
      switch (state.status) {
        case Status.LOADING:
          OverlayLoadingView.show(context);
          break;
        case Status.SUCCESS:
          OverlayLoadingView.hide();
          setState(() {
            boardGames = state.data!;
            checkedList = List.generate(boardGames.length, (index) => false);
          });
          break;
        case Status.ERROR:
          OverlayLoadingView.hide();
          ErrorView.show(context, state.exception!.toString(), () {
            print("Error al obtener todos los juegos de la BD");
          });
          break;
      }
    });

    _iPhoneGameViewModel.fetchBoardGames();

    proxyMemberProvider = context.read<ProxyMemberProvider>();

    _iPhoneGameViewModel.fetchBorrowedBoardGames(proxyMemberProvider.getProxyMember().name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("2. Seleccione el juego"),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            //Si no hemos elegido un juego no hacemos nada
            bool findedGame = false;
            for (int i = 0, max = checkedList.length; i < max; i++) {
              if (checkedList[i]) {
                findedGame = true;
                break;
              }
            }

            if (!findedGame) {
              InfoView.show(context, "Elija al menos un juego");
              return;
            }

            //Obtenemos los juegos que se van a prestar
            //Para ello obtenemos todos los indices a true de checkedList
            List<int> indexBoardgamesBorrowed =
                List.generate(checkedList.length, (index) => index)
                    .where((i) => checkedList[i])
                    .toList();

            //ahora comprobamos que el usuario no pueda llevarse mas juegos de los que le corresponde
            if (indexBoardgamesBorrowed.length > 1) {
              InfoView.show(context, "No puedes retir más de 1 juego");
            } else {
              //Ahora comprobamos la cantidad de juegos que se van a retirar mas las que ya tiene en su poder.

              if (indexBoardgamesBorrowed.length + listGamesInMyHouse.length >
                  1) {
                InfoView.show(
                    context, "No puedes tener más de 1 juego en tu poder");
              } else {

                //Una vez obtenidos los indices, seteamos la informacion de cada juego
                List<BoardGame> boardgamesBorrowed = [];
                indexBoardgamesBorrowed.forEach((element) {
                  //Indicamos que el juego ha sido tomado y quien es la persona que lo ha tomado
                  boardGames[element].takenBy =
                      proxyMemberProvider.getProxyMember().name;
                  boardGames[element].taken = true;
                  boardgamesBorrowed.add(boardGames[element]);
                });

                //Aqui debemos comprobar cuantos juegos prestados tengo
                //Si el usuario ha retirado 5 o menos juegos procedemos a actualizar la BD
                _iPhoneGameViewModel.putBorrowedGames(boardgamesBorrowed);
              }
            }
          },
          child: const Icon(Icons.handshake_outlined),
        ),
        body: BoardGameListWidget(
          boardGames: boardGames,
          detailRoute: NavigationRoutes.IPHONE_SCREEN_BOARDGAME_DETAIL_ROUTE,
          checkedList: checkedList,
        ));
  }

}
