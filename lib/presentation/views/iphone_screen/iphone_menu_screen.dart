import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gremio_de_historias/presentation/models/main_menu_screen/item_main_menu.dart';
import 'package:gremio_de_historias/presentation/navigation/navigation_routes.dart';
import 'package:gremio_de_historias/presentation/widgets/commons/button_main_menu.dart';

class IPhoneMenuScreen extends StatelessWidget {
  IPhoneMenuScreen({super.key});
  final List<ItemMainMenu> mainMenuIphoneScreen = [
    ItemMainMenu(iconItem: "assets/icons/collection_games.png", titleItem: "Prestar", route: NavigationRoutes.IPHONE_SCREEN_BOARDGAME_ROUTE, access: 1),
    ItemMainMenu(iconItem: "assets/icons/my_games.png", titleItem: "Devolver", route: NavigationRoutes.IPHONE_SCREEN_DROP_BOARDGAME_ROUTE, access: 1)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1),
            itemCount: mainMenuIphoneScreen.length,
            itemBuilder: (context, index){
              return InkWell(
                onTap: (){
                  //El extra hay que quitarlo
                  context.push(mainMenuIphoneScreen[index].route);
                },
                child: ButtonMainMenu(
                  iconRoute: mainMenuIphoneScreen[index].iconItem,
                  iconTitle: mainMenuIphoneScreen[index].titleItem,
                ) ,
              );
            }
        ),
      ),
    );
  }
}
