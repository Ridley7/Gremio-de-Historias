import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gremio_de_historias/presentation/model/resource_state.dart';
import 'package:gremio_de_historias/presentation/models/lent_game_screen/board_game.dart';
import 'package:gremio_de_historias/presentation/providers/proxy_member_provider.dart';
import 'package:gremio_de_historias/presentation/views/common_model_view/drop_game_view_model.dart';
import 'package:gremio_de_historias/presentation/widgets/commons/dialog_view.dart';
import 'package:gremio_de_historias/presentation/widgets/commons/error_view.dart';
import 'package:gremio_de_historias/presentation/widgets/commons/overlay_loading_view.dart';
import 'package:provider/provider.dart';

class IPhoneDropGameScreen extends StatefulWidget {
  const IPhoneDropGameScreen({super.key});

  @override
  State<IPhoneDropGameScreen> createState() => _IPhoneDropGameScreenState();
}

class _IPhoneDropGameScreenState extends State<IPhoneDropGameScreen> {

  List<BoardGame> boardGames = [];
  final DropGameModelView _dropGameModelView = DropGameModelView();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    final proxyMemberProvider = context.read<ProxyMemberProvider>();

    _dropGameModelView.setBorrowedGameState.stream.listen((state) {
      switch(state.status){

        case Status.LOADING:
          OverlayLoadingView.show(context);
          break;
        case Status.SUCCESS:
          OverlayLoadingView.hide();
          setState(() {
            _dropGameModelView.fetchBorrowedBoardGames(proxyMemberProvider.getProxyMember().name);
          });
          break;
        case Status.ERROR:
          OverlayLoadingView.hide();
          ErrorView.show(context, state.exception!.toString(), (){
            print("Error al devolver el juego en pantalla de iphone");
          });
          break;
      }
    });

    _dropGameModelView.getBorrowedGameBoardState.stream.listen((state) {
      switch(state.status){

        case Status.LOADING:
          OverlayLoadingView.show(context);
          break;
        case Status.SUCCESS:
          OverlayLoadingView.hide();
          setState(() {
            boardGames = state.data!;
          });
          break;
        case Status.ERROR:
          OverlayLoadingView.hide();
          ErrorView.show(context, state.exception!.toString(), (){
            print("Error al cargar los juegos prestados en pantalla de iphone");
          });
          break;
      }
    });

    _dropGameModelView.fetchBorrowedBoardGames(proxyMemberProvider.getProxyMember().name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Juegos prestados"),
        centerTitle: true,
      ),

      body: SafeArea(
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1
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
                      _dropGameModelView.returnBorrowedGame(boardGames[index]);

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
