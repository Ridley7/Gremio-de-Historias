import 'package:flutter/material.dart';

class OverlayLoadingView{
  static OverlayEntry? _overlay;

  static void show(BuildContext context, {Color? backgroundcolor}){
    if(_overlay != null) return;

    _overlay = OverlayEntry(builder: (BuildContext context){
      return Stack(
        children: [
          Container(
            color: backgroundcolor ?? Theme.of(context).scaffoldBackgroundColor,
            child: const Center(
              child: CircularProgressIndicator()),
          )
        ],
      );
    });

    Overlay.of(context).insert(_overlay!);
  }

  static hide(){
    if(_overlay == null) return;
    _overlay!.remove();
    _overlay = null;
  }
}
