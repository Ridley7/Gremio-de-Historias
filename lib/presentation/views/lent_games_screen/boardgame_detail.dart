import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gremio_de_historias/models/lent_game_screen/board_game.dart';

class BoardGameDetail extends StatelessWidget {
  BoardGameDetail({super.key, required this.boardGame});

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
                Text(
                  boardGame.name,
                  style: const TextStyle(fontSize: 30),
                ),
              ],
            ),

            //Portada del juego
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CachedNetworkImage(
                imageUrl: boardGame.urlImage,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),

            //Numero de jugadores
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${boardGame.amountPlayers} Jugadores ",
                  style: const TextStyle(fontSize: 24),
                ),
              ],
            ),

            //Duracion
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  boardGame.duration,
                  style: const TextStyle(fontSize: 24),
                ),
              ],
            ),

            //Edad
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  boardGame.age,
                  style: const TextStyle(fontSize: 24),
                ),
              ],
            ),

            const SizedBox(
              height: 8.0,
            ),

            const Divider(
              color: Colors.black54,
              height: 50,
              thickness: 2,
              indent: 20,
              endIndent: 40,
            ),

            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Observaciones: ",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 8.0,
            ),

            Row(
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      boardGame.observations,
                      textAlign: TextAlign.start,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 8.0,
            ),

            const Divider(
              color: Colors.black54,
              height: 50,
              thickness: 2,
              indent: 20,
              endIndent: 40,
            ),

            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Solicitado anteriormente por: ",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 8.0,
            ),

            SizedBox(
              height: 100.0,
              child: boardGame.oldUsers.isEmpty
                  ? const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                        "Este juego aún no ha dejado la ludoteca. Sé el primero en hacerlo."),
                  )
                  : ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      children: boardGame.oldUsers.take(2).map((nombre) {
                        return ListTile(
                          title: Text(
                            nombre,
                            style: const TextStyle(fontSize: 20),
                          ),
                        );
                      }).toList(),
                    ),
            ),

            const SizedBox(
              height: 16.0,
            ),
          ],
        ),
      ),
    );
  }
}
