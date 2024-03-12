import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gremio_de_historias/di/app_modules.dart';
import 'package:gremio_de_historias/models/login_screen/member.dart';
import 'package:gremio_de_historias/models/resource_state.dart';
import 'package:gremio_de_historias/presentation/constants/strings_app.dart';
import 'package:gremio_de_historias/presentation/providers/member_provider.dart';
import 'package:gremio_de_historias/presentation/views/login_screen/viewmodel/login_view_model.dart';
import 'package:gremio_de_historias/presentation/widgets/commons/error_view.dart';
import 'package:gremio_de_historias/presentation/widgets/commons/loading_view.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final LoginViewModel _loginViewModel = inject<LoginViewModel>();

  String usernamePreferences = "";
  String passPreferences = "";
  Member? miembro;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _loginViewModel.loginMemberState.stream.listen((state) {
      switch (state.status) {
        case Status.LOADING:
          LoadingView.show(context);
          break;
        case Status.SUCCESS:
          LoadingView.hide();
          setState(() {
            miembro = state.data;

            if (miembro == null) {
              //Mostramos snackbar
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text(StringsApp.ERROR_CREDENCIALES_INCORRECTAS),
                duration: Duration(seconds: 3),
              ));
            } else {
              //Llamamos al provider para pasar la informacion del miembro
              final memberProvider = context.read<MemberProvider>();
              memberProvider.setCurrentMember(miembro!);

              //Y vamos al menu principal
              context.go("/mainmenu");
            }
          });
          break;
        case Status.ERROR:
          LoadingView.hide();
          ErrorView.show(context, StringsApp.ERROR_FIREBASE, () {});
      }
    });

    _loadCredentials();
  }

  void _loadCredentials() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    usernamePreferences = preferences.getString("usernamePreferences") ?? "";
    passPreferences = preferences.getString("passPreferences") ?? "";

    await Future.delayed(const Duration(seconds: 3));

    if (usernamePreferences != "" && passPreferences != "") {
      //Si tenemos contenido en los shared preferences hacemos un login normal
      _loginViewModel.performLoginMember(usernamePreferences, passPreferences);
    } else {
      //Si los shared preferences estan vacios vamos a la pantalla de login
      context.go("/login");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: Lottie.asset("assets/animations/animation_dice.json"))
          ],
        ),
      ),
    );
  }
}
