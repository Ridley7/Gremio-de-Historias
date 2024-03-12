import 'package:flutter/material.dart';
import 'package:gremio_de_historias/di/app_modules.dart';
import 'package:gremio_de_historias/models/lent_game_screen/board_game.dart';
import 'package:gremio_de_historias/models/resource_state.dart';
import 'package:gremio_de_historias/presentation/constants/constants_app.dart';
import 'package:gremio_de_historias/presentation/constants/strings_app.dart';
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
  final LentGameViewModel _lentGameViewModel = inject<LentGameViewModel>();
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
            //Comprobamos los juegos que hay en casa, por que si el usuario quiere pedir los
            //juegos de uno en uno, nos revienta.
            _lentGameViewModel.fetchBorrowedBoardGames(memberProvider.getCurrentMember().name);
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
          onPressed: _handleFloatingActionButton,
          child: const Icon(Icons.handshake_outlined),
        ),
        body: BoardGameListWidget(
          boardGames: boardGames,
          detailRoute: NavigationRoutes.BOARDGAME_DETAIL_ROUTE,
          checkedList: checkedList,
        ));
  }

  void _handleFloatingActionButton() {
    final selectedGamesIndexes = checkedList.asMap().entries.where((entry) => entry.value).map((e) => e.key).toList();

    if (selectedGamesIndexes.isEmpty) {
      InfoView.show(context, StringsApp.ERROR_SELECCION_AL_MENOS_UN_JUEGO);
      return;
    }

    if (selectedGamesIndexes.length > ConstantsApp.ALLOWED_GAMES_IN_HOUSE) {
      InfoView.show(context, StringsApp.ERROR_RETIRAS_MAS_DE_UN_JUEGO);
      return;
    }

    if (selectedGamesIndexes.length + listGamesInMyHouse.length > ConstantsApp.ALLOWED_GAMES_IN_HOUSE) {
      InfoView.show(context, StringsApp.ERROR_MAS_DE_UN_JUEGO_EN_CASA);
      return;
    }

    final selectedGame = boardGames[selectedGamesIndexes.first];
    selectedGame.takenBy = memberProvider.getCurrentMember().name;
    selectedGame.taken = true;

    _lentGameViewModel.putBorrowedGames([selectedGame]);
  }
}
