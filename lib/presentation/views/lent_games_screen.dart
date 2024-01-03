import 'package:flutter/material.dart';
import 'package:gremio_de_historias/presentation/models/lent_game_screen/board_game.dart';

class LentGamesScreen extends StatefulWidget {
  const LentGamesScreen({super.key});

  @override
  State<LentGamesScreen> createState() => _LentGamesScreenState();
}

class _LentGamesScreenState extends State<LentGamesScreen> {
  final List<BoardGame> boardGames = [
    BoardGame(name: "Ark Nova", taken: false, takenBy: ""),
    BoardGame(name: "Caylus", taken: false, takenBy: ""),
    BoardGame(name: "Agricola", taken: true, takenBy: "Luis"),
    BoardGame(name: "Ark Nova", taken: false, takenBy: ""),
    BoardGame(name: "Caylus", taken: false, takenBy: ""),
    BoardGame(name: "Agricola", taken: true, takenBy: "Luis"),
    BoardGame(name: "Ark Nova", taken: false, takenBy: ""),
    BoardGame(name: "Caylus", taken: false, takenBy: ""),
    BoardGame(name: "Agricola", taken: true, takenBy: "Luis"),
    BoardGame(name: "Ark Nova", taken: false, takenBy: ""),
    BoardGame(name: "Caylus", taken: false, takenBy: ""),
    BoardGame(name: "Agricola", taken: true, takenBy: "Luis"),
  ];

  List<bool> checkedList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkedList = List.generate(boardGames.length, (index) => false);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Juegos Disponibles"),
        centerTitle: true,
      ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          //Hacemos cosas
        },
        child: const Icon(Icons.add),
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
