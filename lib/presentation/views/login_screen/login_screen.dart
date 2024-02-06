import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:gremio_de_historias/presentation/model/resource_state.dart';
import 'package:gremio_de_historias/presentation/models/login_screen/member.dart';
import 'package:gremio_de_historias/presentation/providers/member_provider.dart';
import 'package:gremio_de_historias/presentation/views/login_screen/viewmodel/login_view_model.dart';
import 'package:gremio_de_historias/presentation/widgets/commons/error_view.dart';
import 'package:gremio_de_historias/presentation/widgets/commons/loading_view.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerNameMember = TextEditingController();
  final TextEditingController _controllerPassMember = TextEditingController();
  bool viewPassword = true;
  Member? miembro;
  
  //MembersRepository _membersRepository = MembersRepository();
  //final LoginViewModel _loginViewModel = LoginViewModel(membersRepository: _membersRepository);
  final LoginViewModel _loginViewModel = LoginViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _loginViewModel.loginMemberState.stream.listen((state) {
      switch(state.status){
        case Status.LOADING:
          LoadingView.show(context);
          break;
        case Status.SUCCESS:
          LoadingView.hide();
          setState(() {
            //Pasan cosas
            miembro = state.data;

            if(miembro == null){

              //Mostramos snackbar
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text("Credenciales incorrectas"),
                    duration: Duration(seconds: 3),
                )
              );

            }else{
              //Llamamos al provider para pasar la informacion del miembro
              final memberProvider = context.read<MemberProvider>();
              memberProvider.setCurrentMember(miembro!);

              //Aqui vamos al menu principal
              context.push("/mainmenu");
              //context.push(mainMenu[index].route);

            }
          });
          break;
        case Status.ERROR:
          LoadingView.hide();
          ErrorView.show(context, state.exception!.toString(), (){
            print("Estas en el Retry");
          });
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            Image.asset("assets/images/logo_gremio.png"),

            const Text("Asociación cultural", style: TextStyle(fontSize: 20),),

            const SizedBox(
              height: 8,
            ),

            Form(
              key: _formKey,
              child: Column(
                children: [
                  //Input para el nombre de usuario
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: TextFormField(
                      controller: _controllerNameMember,
                      decoration: const InputDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: FaIcon(FontAwesomeIcons.user),
                        ),
                        hintText: "Nombre de usuario",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(0)
                          ),
                          borderSide: BorderSide(color: Colors.black54)
                        )
                      ),

                      validator: (value){
                        if(value!.isEmpty){
                          return "Campo obligatorio";
                        }

                        return null;
                      },
                    ),
                  ),

                  const SizedBox(
                    height: 16,
                  ),

                  //Input para la contraseña
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: TextFormField(
                      obscureText: viewPassword,
                      controller: _controllerPassMember,
                      decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IconButton(
                               onPressed: (){
                                 setState(() {
                                   viewPassword = !viewPassword;
                                 });
                               },
                                icon: const FaIcon(FontAwesomeIcons.key),
                            ),
                          ),
                          hintText: "Contraseña",
                          enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(0)
                              ),
                              borderSide: BorderSide(color: Colors.black54)
                          )
                      ),

                      validator: (value){
                        if(value!.isEmpty){
                          return "Campo obligatorio";
                        }

                        return null;
                      },
                    ),
                  ),




                ],
              ),
            ),

            const SizedBox(
              height: 128,
            ),



            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.height * 0.07,
              child: ElevatedButton(
                  onPressed: () async {
                    _loginViewModel.performLoginMember(_controllerNameMember.text, _controllerPassMember.text);

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black87,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2)
                    )
                  ),
                  child: const Text(
                   "Login",
                   style: TextStyle(
                     color: Colors.white, fontSize: 20
                   ),
                  )
              ),
            )
          ],
        ),
      ),
    );
  }
}
