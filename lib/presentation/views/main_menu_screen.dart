import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gremio_de_historias/models/main_menu_screen/item_main_menu.dart';
import 'package:gremio_de_historias/presentation/constants/strings_app.dart';
import 'package:gremio_de_historias/presentation/providers/member_provider.dart';
import 'package:gremio_de_historias/presentation/widgets/commons/button_main_menu.dart';
import 'package:gremio_de_historias/presentation/widgets/commons/loading_view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainMenuScreen extends StatelessWidget {
  MainMenuScreen({super.key});

  final List<ItemMainMenu> optionsMainMenu = [
    ItemMainMenu(
        iconItem: "assets/icons/collection_games.png",
        titleItem: StringsApp.PRESTAMO,
        route: "/lent",
        access: 1),
    ItemMainMenu(
        iconItem: "assets/icons/my_games.png",
        titleItem: StringsApp.DEVOLUCION,
        route: "/owngames",
        access: 1),
    ItemMainMenu(
        iconItem: "assets/icons/iphone.png",
        titleItem: StringsApp.IPHONE,
        route: "/iphone",
        access: 2),
    ItemMainMenu(
        iconItem: "assets/icons/log_out.png",
        titleItem: StringsApp.CERRAR_SESION,
        route: "/",
        access: 1),
  ];

  List<ItemMainMenu> mainMenu = [];

  @override
  Widget build(BuildContext context) {
    //Le pedimos al provider la informacion del miembro
    final memberProvider = context.read<MemberProvider>();

    //Seteamos el tipo de menu que queremos
    optionsMainMenu.forEach((option) {
      if (memberProvider.getCurrentMember().level_access >= option.access) {
        mainMenu.add(option);
      }
    });

    void _cleanCredentials() async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString("usernamePreferences", "");
      preferences.setString("passPreferences", "");
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                      "${StringsApp.USER} ${memberProvider.getCurrentMember().name}"),
                ],
              ),
            ),
            Flexible(
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                  ),
                  itemCount: mainMenu.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () async {
                        //Comprobamos si estamos ante log out
                        if (index == mainMenu.length - 1) {
                          //Limpiamos los shared preferences
                          LoadingView.show(context);
                          _cleanCredentials();
                          //Este await es para evitar un error que de momento no se como tratar
                          await Future.delayed(const Duration(seconds: 2));
                          LoadingView.hide();

                          context.go(mainMenu[index].route);
                        } else {
                          context.push(mainMenu[index].route);
                        }
                      },
                      child: ButtonMainMenu(
                        iconRoute: mainMenu[index].iconItem,
                        iconTitle: mainMenu[index].titleItem,
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
