
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gremio_de_historias/domain/boardgames_repository.dart';
import 'package:gremio_de_historias/presentation/models/lent_game_screen/board_game.dart';
import 'package:gremio_de_historias/presentation/navigation/navigation_routes.dart';
import 'package:gremio_de_historias/presentation/providers/member_provider.dart';
import 'package:gremio_de_historias/presentation/widgets/commons/info_view.dart';
import 'package:gremio_de_historias/presentation/widgets/commons/loading_view.dart';
import 'package:provider/provider.dart';

class LentGamesScreen extends StatefulWidget {
  const LentGamesScreen({super.key});

  @override
  State<LentGamesScreen> createState() => _LentGamesScreenState();
}

class _LentGamesScreenState extends State<LentGamesScreen> {
  List<BoardGame> boardGames = [
  ];

  List<bool> checkedList = [];

  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async{
    final DateTime? picked = await showDatePicker(
        context: context,
        locale: const Locale("es", "ES"),
        helpText: "Seleccione la fecha de devolución",
        //initialDate: selectedDate,
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

  final BoardgamesRepository _boardgamesRepository = BoardgamesRepository();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getBoardGames();
  }

  void _getBoardGames() async{
    boardGames = await _boardgamesRepository.getBoardGames();
    checkedList = List.generate(boardGames.length, (index) => false);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Juegos Disponibles"),
        centerTitle: true,
      ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: () async{

          //Si no hemos elegido ningun juego no hacemos nada
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
          int daysAllowed = selectedDate!.difference(DateTime.now()).inDays;
          if(daysAllowed > 15){
            InfoView.show(context, "La fecha de prestamos no puede exceder los 15 dias");
          }else{
            //Obtenemos los juegos que se van a prestar
            //Para ello obtenemos todos los indices a true de checkedList
            List<int> indexBoardgamesBorrowed = List.generate(
                checkedList.length, (index) => index).where((i) => checkedList[i]).toList();

            //Ahora comprobamos que el usuario no pueda llevarse mas juegos de los que le corresponde
            if(indexBoardgamesBorrowed.length > 1){
              InfoView.show(context, "No puedes retirar más de 1 juego");
            }
            else{

              //Ahora comprobamos la cantidad de juegos que va a retirar más los que ya tiene en su poder
              //La cantidad de juegos que voy a retirar estan en indexBoardgamesBorrowed.length
              //Y ahora obtengo los que tengo en mi poder
              final memberProvider = context.read<MemberProvider>();
              List<BoardGame> listGamesInMyHouse = await _boardgamesRepository.getBorrowedBoardGames(memberProvider.currentMember.name);

              if(indexBoardgamesBorrowed.length + listGamesInMyHouse.length > 1){
                InfoView.show(context, "No puedes tener más de 1 juego en tu poder");
              }else{
                //Una vez obtenidos los indices, seteamos la informacion de cada juego
                List<BoardGame> boardgamesBorrowed = [];
                indexBoardgamesBorrowed.forEach((element) {
                  //Indicamos que el juego ha sido tomado y quien es la persona que lo ha tomado
                  //Llamamos al provider para obtener la información del usuario
                  final memberProvider = context.read<MemberProvider>();
                  boardGames[element].takenBy = memberProvider.getCurrentMember().name;
                  boardGames[element].taken = true;
                  boardgamesBorrowed.add(boardGames[element]);
                });

                //Aqui debemos comprobar cuantos juegos prestados tengo

                //Si el usuario ha retirado 5 o menos juegos procedemos a actualizar la BD
                await _boardgamesRepository.setBorrowedGames(boardgamesBorrowed);

                //Una vez se haya hecho la inserción mostramos mensaje
                LoadingView.show(context);
                await Future.delayed(Duration(seconds: 2));
                LoadingView.hide();
                InfoView.show(context, "Juego retirado correctamente");

                _getBoardGames();
              }
            }
          }
        },
        child: const Icon(Icons.handshake_outlined),
      ),

      body: ListView.builder(
        itemCount: boardGames.length,
          itemBuilder: (context, index){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black12,
                border: Border.all(
                  color: Colors.black,
                  width: 1.0
                ),
                
                borderRadius: BorderRadius.circular(10.0)
              ),
              child: Column(

                children: [
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [

                        InkWell(
                          onTap: (){
                            //Hacemos cosas
                            context.push(NavigationRoutes.BOARDGAME_DETAIL_ROUTE, extra: boardGames[index]);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.60,
                                  child: Text(boardGames[index].name,
                                  style: const TextStyle(
                                    fontSize: 24
                                  ),),
                                ),
                                boardGames[index].taken ?
                                Text("En poder de: ${boardGames[index].takenBy}",
                                  style: const TextStyle(
                                      fontSize: 14
                                  ),)

                                    :
                                    Container()
                              ],
                            ),
                          ),
                        ),

                        Expanded(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.30,
                            decoration: BoxDecoration(
                              color: Colors.black26,
                              border: const Border(
                                left: BorderSide(
                                  color: Colors.black,
                                  width: 1.0
                                ),
                              ),
                              borderRadius: BorderRadius.circular(10.0)
                            ),
                            child: Checkbox(
                              value: checkedList[index],
                              onChanged: boardGames[index].taken ? null :

                                  (value){
                                setState(() {
                                  checkedList[index] = value!;
                                });
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )
            ),
          );
          }
      ),
    );
  }
}
