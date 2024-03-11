import 'package:flutter/material.dart';
import 'package:gremio_de_historias/presentation/constants/StringsApp.dart';

class ErrorView {
  static show(BuildContext context, String message, Function onRetry) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          icon: const Icon(Icons.error_outline),
          title: const Text(StringsApp.ERROR),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text(StringsApp.CANCELAR),
            ),
            TextButton(
              onPressed: () {
                onRetry.call();
                Navigator.of(dialogContext).pop();
              },
              child: const Text(StringsApp.RETRY),
            )
          ],
        );
      },
    );
  }
}
