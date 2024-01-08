import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _contollerNameMember = TextEditingController();

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

            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _contollerNameMember,
                    decoration: const InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: FaIcon(FontAwesomeIcons.user),
                      ),
                      hintText: "Hint text",
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
                  )
                ],
              ),
            )


          ],
        ),
      ),
    );
  }
}
