import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gremio_de_historias/domain/boardgames_repository.dart';
import 'package:gremio_de_historias/presentation/models/lent_game_screen/board_game.dart';
import 'package:gremio_de_historias/presentation/providers/member_provider.dart';
import 'package:gremio_de_historias/presentation/widgets/commons/dialog_view.dart';
import 'package:provider/provider.dart';

class OwnGamesScreen extends StatefulWidget {
  const OwnGamesScreen({super.key});

  @override
  State<OwnGamesScreen> createState() => _OwnGamesScreenState();
}

class _OwnGamesScreenState extends State<OwnGamesScreen> {

  List<BoardGame> boardGames = [];

  final BoardgamesRepository _boardgamesRepository = BoardgamesRepository();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getBorrowedGames();
  }

  void _getBorrowedGames() async{
    //Necesito el provider
    final memberProvider = context.read<MemberProvider>();
    boardGames = await _boardgamesRepository.getBorrowedBoardGames(memberProvider.currentMember.name);
    setState(() {});
  }

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
                    DialogView.show(context, "¿Seguro que deseas devolver este juego?", (){
                      boardGames[index].takenBy = "";
                      boardGames[index].taken = false;
                      _boardgamesRepository.returnBorrowedGame(boardGames[index]);
                      _getBorrowedGames();
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

