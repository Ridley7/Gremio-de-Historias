import 'package:flutter/material.dart';

class IphoneMemberScreen extends StatefulWidget {
  const IphoneMemberScreen({super.key});

  @override
  State<IphoneMemberScreen> createState() => _IphoneMemberScreenState();
}

class _IphoneMemberScreenState extends State<IphoneMemberScreen> {

  //Me quedo aqui, proximos pasos.
  //1. hacer un iphoneMemberModelView y traer a todos los miembros
  //2. hacer una lista de juegos para alquilar.
  List<String> nameMembers = ["Hose", "Maria", "Juan"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: nameMembers.length,
            itemBuilder: (BuildContext context, int index){
            return ListTile(
              title: Text(nameMembers[index]),
              onTap: (){},
            );
            }
        ),
      ),
    );
  }
}
