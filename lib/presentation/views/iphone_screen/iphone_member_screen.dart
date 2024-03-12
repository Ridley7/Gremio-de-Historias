import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gremio_de_historias/di/app_modules.dart';
import 'package:gremio_de_historias/models/login_screen/member.dart';
import 'package:gremio_de_historias/models/resource_state.dart';
import 'package:gremio_de_historias/presentation/constants/strings_app.dart';
import 'package:gremio_de_historias/presentation/navigation/navigation_routes.dart';
import 'package:gremio_de_historias/presentation/providers/proxy_member_provider.dart';
import 'package:gremio_de_historias/presentation/views/iphone_screen/viewmodel/iphone_member_view_model.dart';
import 'package:gremio_de_historias/presentation/widgets/commons/error_view.dart';
import 'package:gremio_de_historias/presentation/widgets/commons/overlay_loading_view.dart';
import 'package:provider/provider.dart';

class IphoneMemberScreen extends StatefulWidget {
  const IphoneMemberScreen({super.key});

  @override
  State<IphoneMemberScreen> createState() => _IphoneMemberScreenState();
}

class _IphoneMemberScreenState extends State<IphoneMemberScreen> {
  List<Member> members = [];

  final IPhoneMemberViewModel _iphoneMemberViewModel = inject<IPhoneMemberViewModel>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _iphoneMemberViewModel.getIphoneMemberState.stream.listen((state) {
      switch (state.status) {
        case Status.LOADING:
          OverlayLoadingView.show(context);
          break;
        case Status.SUCCESS:
          OverlayLoadingView.hide();
          setState(() {
            members = state.data!;
          });
          break;
        case Status.ERROR:
          OverlayLoadingView.hide();
          ErrorView.show(context, StringsApp.ERROR_OBTENER_MIEMBROS, () {
            _iphoneMemberViewModel.fetchMembers();
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
    final proxyMemberProvider = context.read<ProxyMemberProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(StringsApp.SELECCIONE_MIEMBRO),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Divider(
              color: Colors.black54,
            ),
            Flexible(
              child: ListView.separated(
                  separatorBuilder: (context, index) => const Divider(
                        color: Colors.black54,
                      ),
                  itemCount: members.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(members[index].name),
                      onTap: () {
                        proxyMemberProvider.setProxyMember(members[index]);
                        context.push(NavigationRoutes.IPHONE_SCREEN_MENU_ROUTE);
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
