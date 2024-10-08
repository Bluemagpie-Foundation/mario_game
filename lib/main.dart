import 'package:flutter/material.dart';

import 'game_world.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Mario Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GameWorld(),
    );
  }
}
