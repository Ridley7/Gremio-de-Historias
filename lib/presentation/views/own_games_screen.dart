import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gremio_de_historias/presentation/models/lent_game_screen/board_game.dart';

class OwnGamesScreen extends StatefulWidget {
  const OwnGamesScreen({super.key});

  @override
  State<OwnGamesScreen> createState() => _OwnGamesScreenState();
}

class _OwnGamesScreenState extends State<OwnGamesScreen> {

  final List<BoardGame> boardGames = [
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
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Juegos prestados"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
            ),
            itemCount: boardGames.length,
            itemBuilder: (context, index){
              return Card(
                margin: const EdgeInsets.all(32.0),
                child: InkWell(
                  onTap: (){
                    //Aqui sacamos modal para devolver juego

                  },
                  child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 200,
                                child: CachedNetworkImage(
                                  imageUrl: boardGames[index].urlImage,
                                  fit: BoxFit.fill,
                                )
                              )
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Text("${index + 1}. ${boardGames[index].name}",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                ),),
                              )
                            ],
                          )
                        ],
                      )
                  ),
                ),
              );
            }
        ),
      ),
    );
  }
}
