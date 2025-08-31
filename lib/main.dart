import 'package:flutter/material.dart';
import 'package:mastermindv/Components/GamePage/GamePage.dart';
import 'package:mastermindv/Components/mainScreen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MainScreen(),
      // home: GamePage(),
    );
  }
}

