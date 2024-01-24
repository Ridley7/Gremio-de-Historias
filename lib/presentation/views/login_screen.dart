import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
                  onPressed: (){},
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
