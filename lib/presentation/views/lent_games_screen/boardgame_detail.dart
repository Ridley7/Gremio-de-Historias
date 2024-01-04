import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gremio_de_historias/presentation/models/lent_game_screen/board_game.dart';

class BoardGameDetail extends StatelessWidget {
  const BoardGameDetail({
    super.key,
    required this.boardGame
  });

  final BoardGame boardGame;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalle"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            //Titulo del juego
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(boardGame.name, style: const TextStyle(fontSize: 30),),
              ],
            ),

            //Portada del juego
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CachedNetworkImage(
                  imageUrl: boardGame.urlImage,
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),

            //Numero de jugadores
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(boardGame.amountPlayers, style: const TextStyle(fontSize: 24),),
              ],
            ),

            //Duracion
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(boardGame.duration, style: const TextStyle(fontSize: 24),),
              ],
            ),

            //Edad
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(boardGame.age, style: const TextStyle(fontSize: 24),),
              ],
            ),

            const SizedBox(
              height: 8.0,
            ),

            const Row(
              children: [
                Text("Observaciones: ", style: TextStyle(fontSize: 24),),
              ],
            ),

            const SizedBox(
              height: 8.0,
            ),

            Wrap(
              children: [
                Text(boardGame.observations, style: const TextStyle(fontSize: 20),),
              ],
            ),


          ],
        ),
      ),
    );
  }
}
