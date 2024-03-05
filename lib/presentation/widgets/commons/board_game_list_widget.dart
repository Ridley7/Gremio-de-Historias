import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gremio_de_historias/models/lent_game_screen/board_game.dart';

class BoardGameListWidget extends StatefulWidget {
  BoardGameListWidget({
    super.key,
    required this.boardGames,
    required this.detailRoute,
    required this.checkedList
  });

  List<BoardGame> boardGames;
  String detailRoute;
  List<bool> checkedList;

  @override
  State<BoardGameListWidget> createState() => _BoardGameListWidgetState();
}

class _BoardGameListWidgetState extends State<BoardGameListWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.boardGames.length,
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
                          context.push(widget.detailRoute, extra: widget.boardGames[index]);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.60,
                                child: Text(widget.boardGames[index].name,
                                  style: const TextStyle(
                                      fontSize: 24
                                  ),),
                              ),
                              widget.boardGames[index].taken ?
                              Text("En poder de: ${widget.boardGames[index].takenBy}",
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
                              value: widget.checkedList[index],
                              onChanged: widget.boardGames[index].taken ? null :

                                  (value){
                                setState(() {
                                  widget.checkedList[index] = value!;
                                });
                              },
                            ),
                          )
                      )

                    ],
                  ),
                )
              ],
            ),
          ),
        );
        }
    );
  }
}
