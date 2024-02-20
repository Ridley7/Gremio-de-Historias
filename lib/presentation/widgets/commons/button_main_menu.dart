import 'package:flutter/material.dart';

class ButtonMainMenu extends StatelessWidget {
  const ButtonMainMenu({
    super.key,
    required this.iconRoute,
    required this.iconTitle
  });

  final String iconRoute;
  final String iconTitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(64.0),
      child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 200,
                    child: Image.asset(iconRoute, fit: BoxFit.fill,),
                  )
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(iconTitle, style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold
                  ),)
                ],
              )
            ],
          )
      ),
    );
  }
}