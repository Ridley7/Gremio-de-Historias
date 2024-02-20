import 'package:flutter/material.dart';
import 'package:gremio_de_historias/presentation/model/resource_state.dart';
import 'package:gremio_de_historias/presentation/models/lent_game_screen/board_game.dart';
import 'package:gremio_de_historias/presentation/navigation/navigation_routes.dart';
import 'package:gremio_de_historias/presentation/views/iphone_screen/viewmodel/iphone_game_view_model.dart';
import 'package:gremio_de_historias/presentation/widgets/commons/board_game_list_widget.dart';
import 'package:gremio_de_historias/presentation/widgets/commons/error_view.dart';
import 'package:gremio_de_historias/presentation/widgets/commons/info_view.dart';
import 'package:gremio_de_historias/presentation/widgets/commons/overlay_loading_view.dart';

class IPhoneGameScreen extends StatefulWidget {
  const IPhoneGameScreen({
    super.key,
    required this.memberName
  });

  final String memberName;

  @override
  State<IPhoneGameScreen> createState() => _IPhoneGameScreenState();
}
class _IPhoneGameScreenState extends State<IPhoneGameScreen> {

  final IPhoneGameViewModel _iPhoneGameViewModel = IPhoneGameViewModel();
  List<BoardGame> boardGames = [];
  List<bool> checkedList = [];
  DateTime? selectedDate;
  List<BoardGame> listGamesInMyHouse = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _iPhoneGameViewModel.setIphoneBorrowedGamesState.stream.listen((state) {
      switch(state.status){
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
          ErrorView.show(context, state.exception!.toString(), (){
            print("Error al guardar los juegos que se prestan");
          });
          break;
      }
    });

    _iPhoneGameViewModel.getIphoneBorrowedBoardGameState.stream.listen((state) {
      switch(state.status){
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
          ErrorView.show(context, state.exception!.toString(), (){
            print("Error al obtener los juegos en poder del usuario");
          });
          break;
      }
    });

    _iPhoneGameViewModel.getIphoneBoardGameState.stream.listen((state) {
      switch(state.status){
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
          ErrorView.show(context, state.exception!.toString(), (){
            print("Error al obtener todos los juegos de la BD");
          });
          break;
      }
    });

    _iPhoneGameViewModel.fetchBoardGames();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("2. Seleccione el juego"),
        centerTitle: true,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          //Si no hemos elegido un juego no hacemos nada
          bool findedGame = false;
          for(int i = 0, max = checkedList.length; i < max; i++){
            if(checkedList[i]){
              findedGame = true;
              break;
            }
          }

          if(!findedGame){
            InfoView.show(context, "Elija al menos un juego");
            return;
          }

          //Comprobamos si podemos hacer el prestamo
          await _selectDate(context);

          //Si no hemos elegido fecha no hacemos nada
          if(selectedDate == null){ return; }

          //Comprobamos si el dia elegido de devolucion no supera el mes
          int dayAllowed = selectedDate!.difference(DateTime.now()).inDays;
          if(dayAllowed > 15){
            InfoView.show(context, "La fecha de prestamos no puede exceder los 15 dias");
          }
          else
          {
            //Obtenemos los juegos que se van a prestar
            //Para ello obtenemos todos los indices a true de checkedList
            List<int> indexBoardgamesBorrowed = List.generate(
                checkedList.length, (index) => index).where((i) => checkedList[i]).toList();

            //ahora comprobamos que el usuario no pueda llevarse mas juegos de los que le corresponde
            if(indexBoardgamesBorrowed.length > 1){
              InfoView.show(context, "No puedes retir más de 1 juego");
            }
            else
            {
              //Ahora comprobamos la cantidad de juegos que se van a retirar mas las que ya tiene en su poder.
              //List<BoardGame> listGamesInMyHouse = await _boardgamesRepository.getBorrowedBoardGames(widget.memberName);
              _iPhoneGameViewModel.fetchBorrowedBoardGames(widget.memberName);

              if(indexBoardgamesBorrowed.length + listGamesInMyHouse.length > 1){
                InfoView.show(context, "No puedes tener más de 1 juego en tu poder");
              }
              else
              {
                //Una vez obtenidos los indices, seteamos la informacion de cada juego
                List<BoardGame> boardgamesBorrowed = [];
                indexBoardgamesBorrowed.forEach((element) {
                  //Indicamos que el juego ha sido tomado y quien es la persona que lo ha tomado
                  boardGames[element].takenBy = widget.memberName;
                  boardGames[element].taken = true;
                  boardgamesBorrowed.add(boardGames[element]);
                });

                //Aqui debemos comprobar cuantos juegos prestados tengo
                //Si el usuario ha retirado 5 o menos juegos procedemos a actualizar la BD
                _iPhoneGameViewModel.putBorrowedGames(boardgamesBorrowed);
              }
            }
          }
        },
        child: const Icon(Icons.handshake_outlined),
      ),

      body: BoardGameListWidget(
        boardGames: boardGames,
        detailRoute: NavigationRoutes.IPHONE_SCREEN_BOARDGAME_DETAIL_ROUTE,
        checkedList: checkedList,
      )
    );
  }

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
}