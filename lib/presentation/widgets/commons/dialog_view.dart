import 'package:flutter/material.dart';

class DialogView{
  static BuildContext? _dialogContext;

  static show(BuildContext context, String message, Function onDone){

    showDialog(
        context: context,
        builder: (BuildContext dialogContext){
          _dialogContext = dialogContext;

          return AlertDialog(
            title: const Text("Devolver Juego"),
            content: Text(message),
            actions: [
              TextButton(
                  onPressed:(){
                    Navigator.of(_dialogContext!).pop();
                  },
                  child: const Text("Cancelar")
              ),

              TextButton(
                  onPressed:(){
                    onDone.call();
                    Navigator.of(_dialogContext!).pop();
                  },
                  child: const Text("Aceptar")
              ),
            ],
          );
        }
    );
  }
}