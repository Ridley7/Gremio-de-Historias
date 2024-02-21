import 'package:flutter/material.dart';

class IPhoneDropGameScreen extends StatefulWidget {
  const IPhoneDropGameScreen({super.key});

  @override
  State<IPhoneDropGameScreen> createState() => _IPhoneDropGameScreenState();
}

class _IPhoneDropGameScreenState extends State<IPhoneDropGameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Juegos prestados"),
      ),
    );
  }
}
