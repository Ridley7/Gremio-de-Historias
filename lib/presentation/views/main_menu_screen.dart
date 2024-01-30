import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gremio_de_historias/presentation/models/main_menu_screen/item_main_menu.dart';
import 'package:gremio_de_historias/presentation/providers/member_provider.dart';
import 'package:provider/provider.dart';

class MainMenuScreen extends StatelessWidget {
  MainMenuScreen({super.key});

  final List<ItemMainMenu> mainMenu = [
    ItemMainMenu(iconItem: "assets/icons/collection_games.png", titleItem: "Prestamo", route: "/lent", access: 1),
    ItemMainMenu(iconItem: "assets/icons/my_games.png", titleItem: "Mis Juegos", route: "/owngames", access: 1),
    ItemMainMenu(iconItem: "assets/icons/iphone.png", titleItem: "iPhone", route: "/lent", access: 2),
  ];

  @override
  Widget build(BuildContext context) {

    //Le pedimos al provider la informacion del miembro
    final memberProvider = context.read<MemberProvider>();
    print("El rol de miembto es: " + memberProvider.currentMember.level_access.toString());

    return Scaffold(
      body: SafeArea(
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
            ),
            itemCount: mainMenu.length,
            itemBuilder: (context, index){

              if(memberProvider.currentMember.level_access >= mainMenu[index].access){
                return InkWell(
                  onTap: (){
                    context.push(mainMenu[index].route);
                  },
                  child: Card(
                    margin: const EdgeInsets.all(64.0),
                    child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 200,
                                  child: Image.asset(mainMenu[index].iconItem, fit: BoxFit.fill,),
                                )
                              ],
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(mainMenu[index].titleItem, style: const TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold
                                ),)
                              ],
                            )
                          ],
                        )
                    ),
                  ),
                );
              }


            }
        ),
      ),
    );
  }
}


