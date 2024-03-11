import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gremio_de_historias/models/lent_game_screen/board_game.dart';
import 'package:gremio_de_historias/presentation/constants/strings_app.dart';
import 'package:gremio_de_historias/presentation/views/common_model_view/drop_game_view_model.dart';
import 'package:gremio_de_historias/presentation/widgets/commons/dialog_view.dart';

class CardDropGame extends StatelessWidget {
  CardDropGame({
    super.key,
    required DropGameModelView dropGameModelView,
    required this.boardGame,
    required this.index
  }) : _dropGameModelView = dropGameModelView;

  final DropGameModelView _dropGameModelView;
  final BoardGame boardGame;
  final int index;

  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    //Seteamos el valor del textEditingController
    textEditingController.text = boardGame.observations;

    return Card(
      margin: const EdgeInsets.all(32.0),
      child: InkWell(
        onTap: (){
          //Aqui sacamos modal para devolver juego
          DialogView.show(context, StringsApp.SEGURO_DEVOLUCION, textEditingController, (){
         //Insertamos el nombre del usuario que va a devolver el libro en la lista de usuarios
            //que han solicitado el juego
            String oldUser = "${boardGame.takenBy} - ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
            boardGame.oldUsers.insert(0, oldUser);

            if(boardGame.oldUsers.length > 10){
              boardGame.oldUsers.removeLast();
            }

            boardGame.takenBy = "";
            boardGame.taken = false;
            boardGame.observations = textEditingController.text;

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
