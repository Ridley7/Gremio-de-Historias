import 'package:flutter/material.dart';
import 'package:gremio_de_historias/presentation/constants/StringsApp.dart';

class ReturnGameDialogView{
  static BuildContext? _dialogContext;

  static show(BuildContext context, String message, Function onDone){

    showDialog(
        context: context,
        builder: (BuildContext dialogContext){
          _dialogContext = dialogContext;

          return AlertDialog(
            title: const Text(StringsApp.DEVOLVER_JUEGO),
            content: Text(message),
            actions: [
              TextButton(
                  onPressed:(){
                    Navigator.of(_dialogContext!).pop();
                  },
                  child: const Text(StringsApp.CANCELAR)
              ),

              TextButton(
                  onPressed:(){
                    onDone.call();
                    Navigator.of(_dialogContext!).pop();
                  },
                  child: const Text(StringsApp.ACEPTAR)
              ),
            ],
          );
        }
    );
  }
}