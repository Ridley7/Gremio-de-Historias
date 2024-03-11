import 'package:flutter/material.dart';
import 'package:gremio_de_historias/presentation/constants/strings_app.dart';

class InfoView{
  static BuildContext? _dialogContext;

  static show(BuildContext context, String message){

    showDialog(
        context: context,
        builder: (BuildContext dialogContext){
          _dialogContext = dialogContext;

          return AlertDialog(
            title: const Text(StringsApp.INFORMACION),
            content: Text(message),
            actions: [
              TextButton(
                  onPressed:(){
                    Navigator.of(_dialogContext!).pop();
                  },
                  child: const Text(StringsApp.ACEPTAR)
              )
            ],
          );
        }
    );
  }
}