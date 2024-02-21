import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gremio_de_historias/presentation/models/lent_game_screen/board_game.dart';
import 'package:gremio_de_historias/presentation/views/common_model_view/drop_game_view_model.dart';
import 'package:gremio_de_historias/presentation/widgets/commons/dialog_view.dart';

class CardDropGame extends StatelessWidget {
  const CardDropGame({
    super.key,
    required DropGameModelView dropGameModelView,
    required this.boardGame,
    required this.index
  }) : _dropGameModelView = dropGameModelView;

  final DropGameModelView _dropGameModelView;
  final BoardGame boardGame;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(32.0),
      child: InkWell(
        onTap: (){
          //Aqui sacamos modal para devolver juego
          DialogView.show(context, "¿Seguro que deseas devolver este juego?", (){
            boardGame.takenBy = "";
            boardGame.taken = false;
            _dropGameModelView.returnBorrowedGame(boardGame);
          });
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
                          imageUrl: boardGame.urlImage,
                          fit: BoxFit.fill,
                        )
                    )
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text("${index + 1}. ${boardGame.name}",
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
}
