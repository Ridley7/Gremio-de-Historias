import 'package:flutter/material.dart';

class MainMenu extends StatelessWidget {
  MainMenu({super.key});

  final List<int> numbers = List.generate(100, (index) => index + 1);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
            ),
            itemCount: 3,
            itemBuilder: (context, index){
              return Card(
                margin: const EdgeInsets.all(64.0),
                color: Colors.black12,
                child: Center(
                  child: Image.asset("assets/icons/collection_games.png")
                ),
              );
            }

        ),
      ),
    );
  }
}


