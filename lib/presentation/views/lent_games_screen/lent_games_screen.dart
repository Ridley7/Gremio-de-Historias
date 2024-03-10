import 'package:flutter/material.dart';
import 'package:gremio_de_historias/models/lent_game_screen/board_game.dart';
import 'package:gremio_de_historias/models/resource_state.dart';
import 'package:gremio_de_historias/presentation/constants/StringsApp.dart';
import 'package:gremio_de_historias/presentation/navigation/navigation_routes.dart';
import 'package:gremio_de_historias/presentation/providers/member_provider.dart';
import 'package:gremio_de_historias/presentation/views/lent_games_screen/viewmodel/lent_game_view_model.dart';
import 'package:gremio_de_historias/presentation/widgets/commons/board_game_list_widget.dart';
import 'package:gremio_de_historias/presentation/widgets/commons/error_view.dart';
import 'package:gremio_de_historias/presentation/widgets/commons/info_view.dart';
import 'package:gremio_de_historias/presentation/widgets/commons/overlay_loading_view.dart';
import 'package:provider/provider.dart';

class LentGamesScreen extends StatefulWidget {
  const LentGamesScreen({super.key});

  @override
  State<LentGamesScreen> createState() => _LentGamesScreenState();
}

class _LentGamesScreenState extends State<LentGamesScreen> {
  final LentGameViewModel _lentGameViewModel = LentGameViewModel();
  List<BoardGame> boardGames = [];
  List<bool> checkedList = [];
  DateTime? selectedDate;
  List<BoardGame> listGamesInMyHouse = [];

  late final MemberProvider memberProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    memberProvider = context.read<MemberProvider>();

    _lentGameViewModel.setBorrowedGameState.stream.listen((state) {
      switch (state.status) {
        case Status.LOADING:
          OverlayLoadingView.show(context);
          break;
        case Status.SUCCESS:
          OverlayLoadingView.hide();
          InfoView.show(context, StringsApp.JUEGO_RETIRADO);
          setState(() {
            _lentGameViewModel.fetchBoardGames();
          });
          break;
        case Status.ERROR:
          OverlayLoadingView.hide();
          ErrorView.show(context, StringsApp.ERROR_GUARDAR_JUEGOS, () {});
          break;
      }
    });

    _lentGameViewModel.getBorrowedGameBoardState.stream.listen((state) {
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
          ErrorView.show(context, StringsApp.ERROR_OBTENER_JUEGOS_POR_USUARIO, () {
            _lentGameViewModel.fetchBorrowedBoardGames(memberProvider.getCurrentMember().name);
          });
          break;
      }
    });

    _lentGameViewModel.getLentGameState.stream.listen((state) {
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
          ErrorView.show(context, StringsApp.ERROR_OBTENER_TODOS_JUEGOS, () {
            _lentGameViewModel.fetchBoardGames();
          });
          break;
      }
    });

    _lentGameViewModel.fetchBoardGames();

    _lentGameViewModel.fetchBorrowedBoardGames(memberProvider.getCurrentMember().name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(StringsApp.JUEGOS_DISPONIBLES),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            //Si no hemos elegido ningun juego no hacemos nada
            bool findedGame = false;
            for (int i = 0, max = checkedList.length; i < max; i++) {
              if (checkedList[i]) {
                findedGame = true;
                break;
              }
            }

            if (!findedGame) {
              InfoView.show(context, StringsApp.ERROR_SELECCION_AL_MENOS_UN_JUEGO);
              return;
            }

            //Obtenemos los juegos que se van a prestar
            //Para ello obtenemos todos los indices a true de checkedList
            List<int> indexBoardgamesBorrowed =
                List.generate(checkedList.length, (index) => index)
                    .where((i) => checkedList[i])
                    .toList();

            //Ahora comprobamos que el usuario no pueda llevarse mas juegos de los que le corresponde
            if (indexBoardgamesBorrowed.length > 1) {
              InfoView.show(context, StringsApp.ERROR_RETIRAS_MAS_DE_UN_JUEGO);
            } else {
              //Ahora comprobamos la cantidad de juegos que va a retirar más los que ya tiene en su poder
              //La cantidad de juegos que voy a retirar estan en indexBoardgamesBorrowed.length
              //Y ahora obtengo los que tengo en mi poder

              if (indexBoardgamesBorrowed.length + listGamesInMyHouse.length >
                  1) {
                InfoView.show(
                    context, StringsApp.ERROR_MAS_DE_UN_JUEGO_EN_CASA);
              } else {

                //Una vez obtenidos los indices, seteamos la informacion de cada juego
                List<BoardGame> boardgamesBorrowed = [];
                indexBoardgamesBorrowed.forEach((element) {
                  //Indicamos que el juego ha sido tomado y quien es la persona que lo ha tomado
                  //Llamamos al provider para obtener la información del usuario
                  boardGames[element].takenBy = memberProvider.getCurrentMember().name;
                  boardGames[element].taken = true;
                  boardgamesBorrowed.add(boardGames[element]);
                });

                //Aqui debemos comprobar cuantos juegos prestados tengo
                //Si el usuario ha retirado 5 o menos juegos procedemos a actualizar la BD
                _lentGameViewModel.putBorrowedGames(boardgamesBorrowed);
              }
            }
          },
          child: const Icon(Icons.handshake_outlined),
        ),
        body: BoardGameListWidget(
          boardGames: boardGames,
          detailRoute: NavigationRoutes.BOARDGAME_DETAIL_ROUTE,
          checkedList: checkedList,
        ));
  }

/*
  Future<void> _selectDate(BuildContext context) async{
    final DateTime? picked = await showDatePicker(
        context: context,
        locale: const Locale("es", "ES"),
        helpText: "Seleccione la fecha de devolución",
        initialDate: DateTime.now(),
        firstDate: DateTime.now().subtract(const Duration(days: 30)),
        lastDate: DateTime.now().add(const Duration(days: 30))
    );

    if(picked != null && picked != selectedDate){
      setState(() {
        selectedDate = picked!;
      });
    }
  }
  */
}
