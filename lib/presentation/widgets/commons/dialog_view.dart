import 'package:flutter/material.dart';
import 'package:gremio_de_historias/presentation/constants/strings_app.dart';

class DialogView{
  static BuildContext? _dialogContext;

  static show(BuildContext context, String message, TextEditingController textEditingController, Function onDone){

    showDialog(
        context: context,
        builder: (BuildContext dialogContext){
          _dialogContext = dialogContext;

          return AlertDialog(
            title: const Text(StringsApp.DEVOLVER_JUEGO),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Text(message),
                  TextField(
                    autofocus: true,
                    decoration: const InputDecoration(hintText: StringsApp.OBSERVACIONES),
                    controller: textEditingController,
                    minLines: 1,
                    maxLines: 10,

                  )
                ],
              ),
            ),

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