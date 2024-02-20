import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gremio_de_historias/presentation/model/resource_state.dart';
import 'package:gremio_de_historias/presentation/models/login_screen/member.dart';
import 'package:gremio_de_historias/presentation/navigation/navigation_routes.dart';
import 'package:gremio_de_historias/presentation/views/iphone_screen/viewmodel/iphone_member_view_model.dart';
import 'package:gremio_de_historias/presentation/widgets/commons/error_view.dart';
import 'package:gremio_de_historias/presentation/widgets/commons/loading_view.dart';
import 'package:gremio_de_historias/presentation/widgets/commons/overlay_loading_view.dart';

class IphoneMemberScreen extends StatefulWidget {
  const IphoneMemberScreen({super.key});

  @override
  State<IphoneMemberScreen> createState() => _IphoneMemberScreenState();
}

class _IphoneMemberScreenState extends State<IphoneMemberScreen> {

  //Me quedo aqui, proximos pasos.
  //1. hacer un iphoneMemberModelView y traer a todos los miembros
  //2. hacer una lista de juegos para alquilar.
  List<Member> members = [];

  final IPhoneMemberViewModel _iphoneMemberViewModel = IPhoneMemberViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _iphoneMemberViewModel.getIphoneMemberState.stream.listen((state) {
      switch(state.status){

        case Status.LOADING:
          //LoadingView.show(context);
        OverlayLoadingView.show(context);
          break;
        case Status.SUCCESS:
          //LoadingView.hide();
        OverlayLoadingView.hide();
          setState(() {
            members = state.data!;
          });
          break;
        case Status.ERROR:
          //LoadingView.hide();
        OverlayLoadingView.hide();
          ErrorView.show(context, state.exception!.toString(), (){
            print("Estas en el Retry");
          });
          break;
      }
    });

    _iphoneMemberViewModel.fetchMembers();
  }


  @override
  void dispose() {
    // TODO: implement dispose
    _iphoneMemberViewModel.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("1. Seleccione el miembro"),),
      body: SafeArea(
        child: ListView.builder(
          itemCount: members.length,
            itemBuilder: (BuildContext context, int index){
            return ListTile(
              title: Text(members[index].name),
              onTap: (){
                //Aqui necesitamos un provider

                context.push(NavigationRoutes.IPHONE_SCREEN_BOARDGAME_ROUTE, extra: members[index].name);
              },
            );
            }
        ),
      ),
    );
  }
}
