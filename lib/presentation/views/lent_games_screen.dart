import 'package:flutter/material.dart';
import 'package:gremio_de_historias/presentation/models/lent_game_screen/board_game.dart';

class LentGamesScreen extends StatefulWidget {
  LentGamesScreen({super.key});

  @override
  State<LentGamesScreen> createState() => _LentGamesScreenState();
}

class _LentGamesScreenState extends State<LentGamesScreen> {
  final List<BoardGame> boardGames = [
    BoardGame(name: "Ark Nova"),
    BoardGame(name: "Caylus"),
    BoardGame(name: "Agricola")
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

      body: ListView.builder(
        itemCount: boardGames.length,
          itemBuilder: (context, index){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.red,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: (){
                          //Hacemos cosas
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.60,
                                child: Text(boardGames[index].name,
                                style: const TextStyle(
                                  fontSize: 36

                                ),),
                              ),

                              Text("Prestado por",
                                style: const TextStyle(
                                    fontSize: 14
                                ),),


                            ],
                          ),
                        ),
                      ),

                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.30,
                          color: Colors.green,
                          child: Checkbox(
                            value: checkedList[index],
                            onChanged: (value){
                              setState(() {
                                checkedList[index] = value!;
                              });
                            },
                          ),
                        ),
                      )
                    ],
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
