import 'package:flutter/material.dart';

class DialogView{
  static BuildContext? _dialogContext;

  static show(BuildContext context, String message, TextEditingController textEditingController, Function onDone){

    showDialog(
        context: context,
        builder: (BuildContext dialogContext){
          _dialogContext = dialogContext;

          return AlertDialog(
            title: const Text("Devolver Juego"),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Text(message),
                  TextField(
                    autofocus: true,
                    decoration: const InputDecoration(hintText: "Observaciones"),
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