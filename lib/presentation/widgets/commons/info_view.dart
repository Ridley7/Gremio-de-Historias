import 'package:flutter/material.dart';

class InfoView{
  static BuildContext? _dialogContext;

  static show(BuildContext context, String message){

    showDialog(
        context: context,
        builder: (BuildContext dialogContext){
          _dialogContext = dialogContext;

          return AlertDialog(
            title: const Text("Información"),
            content: Text(message),
            actions: [
              TextButton(
                  onPressed:(){
                    Navigator.of(_dialogContext!).pop();
                  },
                  child: const Text("Aceptar")
              )
            ],
          );
        }
    );
  }
}