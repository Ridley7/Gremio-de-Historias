import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BoardGameDetail extends StatelessWidget {
  const BoardGameDetail({super.key});

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
                Text("Titulo del Juego", style: TextStyle(fontSize: 30),),
              ],
            ),

            //Portada del juego
            CachedNetworkImage(
                imageUrl: "https://cf.geekdo-images.com/un5yundwtC6q1U9gWTY8Yw__imagepage/img/hselxMwFjcSqgEvy4iEpbMVVU-A=/fit-in/900x600/filters:no_upscale():strip_icc()/pic6883492.png",
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),

            //Numero de jugadores
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("1 - 4 Jugadores", style: TextStyle(fontSize: 30),),
              ],
            ),

            //Duracion
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("90 - 150 min", style: TextStyle(fontSize: 30),),
              ],
            ),

            //Edad
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Edad: 14+", style: TextStyle(fontSize: 30),),
              ],
            ),

            Row(
              children: [
                Text("Observaciones: ", style: TextStyle(fontSize: 30),),
              ],
            ),

            Wrap(
              children: [
                Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.", style: TextStyle(fontSize: 30),),
              ],
            ),


          ],
        ),
      ),
    );
  }
}
