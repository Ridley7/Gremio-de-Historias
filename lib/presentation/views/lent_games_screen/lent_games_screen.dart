
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
    /*
    BoardGame(
        name: "Ark Nova",
        taken: false, takenBy: "",
        urlImage: "https://cf.geekdo-images.com/SoU8p28Sk1s8MSvoM4N8pQ__imagepage/img/qR1EvTSNPjDa-pNPGxU9HY2oKfs=/fit-in/900x600/filters:no_upscale():strip_icc()/pic6293412.jpg",
        amountPlayers: "1-4 Jugadores",
        age: "10+",
        observations: "",
      duration: "30 - 40 min"
    ),
    BoardGame(
        name: "Caylus",
        taken: false,
        takenBy: "",
        urlImage: "https://cf.geekdo-images.com/yC7nOSc1x5PT-oNnh6TEcQ__imagepage/img/HUgCfII8ZJf95tei5cBtSUIhRe0=/fit-in/900x600/filters:no_upscale():strip_icc()/pic1638795.jpg",
        amountPlayers: "1-4 Jugadores",
        age: "7+",
        observations: "",
      duration: "50 - 60 min"
    ),
    BoardGame(
        name: "Agricola",
        taken: true,
        takenBy: "Luis",
        urlImage: "https://cf.geekdo-images.com/Vf_0TrTfz9yll7rVBvYGsg__imagepage/img/lHic0OlwOos0xdDlNWdFpSmaFaI=/fit-in/900x600/filters:no_upscale():strip_icc()/pic3029377.jpg",
        amountPlayers: "1-4 Jugadores",
        age: "14+",
        observations: "",
      duration: "70 - 120 min"
    )
     */
  ];

  List<bool> checkedList = [];

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async{
    final DateTime? picked = await showDatePicker(
        context: context,
        locale: const Locale("es", "ES"),
        helpText: "Seleccione la fecha de devolución",
        initialDate: selectedDate,
        firstDate: selectedDate.subtract(const Duration(days: 30)),
        lastDate: selectedDate.add(const Duration(days: 30))
    );

    if(picked != null && picked != selectedDate){
      setState(() {
        selectedDate = picked!;
      });
    }
  }

  final BoardgamesRepository _boardgamesRepository = BoardgamesRepository();
  List<BoardGame> games = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getBoardGames();
  }

  void _getBoardGames() async{
    boardGames = await _boardgamesRepository.getBoardGames();
    checkedList = List.generate(boardGames.length, (index) => false);
    setState(() {

    });
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
          //AQUI HACEMOS TODA LA MOVIDA DE PRESTAR JUEGOS

          //Comprobamos si podemos hacer el prestamo
          await _selectDate(context);

          //Comprobamos si el dia elegido de devolucion no supera el mes
          int daysAllowed = selectedDate.difference(DateTime.now()).inDays;
          if(daysAllowed > 15){
            InfoView.show(context, "La fecha de prestamos no puede exceder los 15 dias");
          }else{
            //Obtenemos los juegos que se van a prestar
            //Para ello obtenemos todos los indices a true de checkedList
            List<int> indexBoardgamesBorrowed = List.generate(
                checkedList.length, (index) => index).where((i) => checkedList[i]).toList();

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

            //Con la informacion de los juegos obtenidos comprobamos que no se puedan
            //retirar una alta cantidad de juegos
            if(boardgamesBorrowed.length > 5){
              InfoView.show(context, "No puedes retirar más de 5 juegos");
            }
            else{

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
