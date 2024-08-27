import 'package:flutter/material.dart';

import 'dart:async';

import 'player.dart';
import 'obstacle.dart';
import 'collectible.dart';

class GameWorld extends StatefulWidget {
  @override
  _GameWorldState createState() => _GameWorldState();
}

class _GameWorldState extends State<GameWorld> {
  
  double playerPositionX = 100; // Initial player position

  double playerPositionY = 100;
  int score = 0; // Initial score
  bool isJumping = false;
  bool isGameOver = false;
  List<Obstacle> obstacles = [
    Obstacle(positionX: 200, positionY: 100),
    Obstacle(positionX: 300, positionY: 100),
   
  ];
  List<Collectible> collectibles = [
    Collectible(positionX: 150, positionY: 150),
    Collectible(positionX: 350, positionY: 150)
  ];

  void movePlayerLeft() {
    setState(() {
      playerPositionX -= 10;
      checkCollision();
      checkGameOver();
    });
  }
  
  void movePlayerRight() {
    setState(() {
      playerPositionX += 10;
      checkCollision();
      checkGameOver();
    });
  }
  
  Timer? _leftButtonTimer;
  Timer? _rightButtonTimer;

  void _startLeftButtonTimer() {
    _leftButtonTimer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      movePlayerLeft();
    });
  }
  
  void _stopLeftButtonTimer() {
    _leftButtonTimer?.cancel();
  }
  
  void _startRightButtonTimer() {
    _rightButtonTimer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      movePlayerRight();
    });
  }
  
  void _stopRightButtonTimer() {
    _rightButtonTimer?.cancel();
  }

  void checkCollision(){
    setState(() {
      collectibles.removeWhere((collectible){
        double collectibleCenterX = collectible.positionX + 15;
        double collectibleCenterY = collectible.positionY + 15;
        double playerCenterX = playerPositionX + 25;
        double playerCenterY = playerPositionY + 25;
        double dx = collectibleCenterX - playerCenterX;
        double dy = collectibleCenterY - playerCenterY;
        double distance = (dx * dx + dy * dy);
        if(distance < 900){
          score += 10;
          
        }
        return distance <900;
      });
    });
  }
  void checkGameOver(){
    for(var obstacle in obstacles){
      double obstacleCenterX = obstacle.positionX + 25;
      double obstacleCenterY = obstacle.positionY + 25;
      double playerCenterX = playerPositionX + 25;
      double playerCenterY = playerPositionY + 25;
      double dx = obstacleCenterX - playerCenterX;
      double dy = obstacleCenterY - playerCenterY;
      double distance = (dx * dx + dy * dy);
      if(distance < 900){
        setState(() {
          isGameOver = true;
        });
        showGameOverDialog();
        break;
      }
    }
  }
  void showGameOverDialog(){
    showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: Text('Game Over'),
          content: Text('Your score: $score'),
          actions: [
            TextButton(
              onPressed: (){
                Navigator.of(context).pop();
                setState(() {
                  playerPositionX = 100;
                  playerPositionY = 100;
                  score = 0;
                  collectibles = [
                    Collectible(positionX: 150, positionY: 150),
                    Collectible(positionX: 350, positionY: 150)
                  ];
                  isGameOver = false;
                });
              },
              child: Text('Restart'),
            ),
          ],
        );
      },
    );
  }

  void jumpPlayer() {
    if (!isJumping) {
      isJumping = true;
      double initialPosition = playerPositionY;
      double targetPosition = playerPositionY + 100;

      Timer.periodic(Duration(milliseconds: 16), (timer) {
        setState(() {
          if (playerPositionY < targetPosition) {
            playerPositionY += 5; // Move the player up
          } else {
            timer.cancel();
            // Simulate falling back down
            Timer.periodic(Duration(milliseconds: 16), (fallTimer) {
              setState(() {
                if (playerPositionY > initialPosition) {
                  playerPositionY -= 5; // Move the player down
                } else {
                  fallTimer.cancel();
                  isJumping = false;
                }
              });
            });
          }
          checkCollision();
        });
      });
    }
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
          Player(positionX: playerPositionX, positionY: playerPositionY, onCollect: (dx)=>checkCollision(), onGameOver: () => checkGameOver()),
          ...obstacles,
          ...collectibles,
          Positioned(
            top: 50,
            left: 20,
            child: Text(
              'Score: $score',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          if(isGameOver)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: Text(
                    'Game Over',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
        ],

      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onLongPress: _startLeftButtonTimer,
            onLongPressUp: _stopLeftButtonTimer,
            child: FloatingActionButton(
              onPressed: movePlayerLeft,
              child: Icon(Icons.arrow_left),
            ),
          ),
          GestureDetector(
            onLongPress: _startRightButtonTimer,
            onLongPressUp: _stopRightButtonTimer,
            child: FloatingActionButton(
              onPressed: movePlayerRight,
              child: Icon(Icons.arrow_right),
            ),
          ),
          FloatingActionButton(
            onPressed: jumpPlayer,
            child: Icon(Icons.arrow_upward),
          ),
        ],
      ),
    );
  }
}




