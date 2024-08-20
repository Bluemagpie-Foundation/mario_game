import 'package:flutter/material.dart';

import 'player.dart';

class GameWorld extends StatefulWidget {
  @override
  _GameWorldState createState() => _GameWorldState();
}

class _GameWorldState extends State<GameWorld> {
  double playerPositionX = 100; // Initial player position

  void movePlayerLeft() {
    setState(() {
      playerPositionX -= 10; // Move player 10 units to the left
    });
  }

  void movePlayerRight() {
    setState(() {
      playerPositionX += 10; // Move player 10 units to the right
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: Colors.blue,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 100,
              color: Colors.green,
            ),
          ),
          Player(positionX: playerPositionX),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            onPressed: movePlayerLeft,
            child: Icon(Icons.arrow_left),
          ),
          FloatingActionButton(
            onPressed: movePlayerRight,
            child: Icon(Icons.arrow_right),
          ),
        ],
      ),
    );
  }
}



