import 'package:flutter/material.dart';

class Player extends StatelessWidget {
  final double positionX;
  final double positionY;
  final Function(double) onCollect;
  final Function onGameOver;

  Player({required this.positionX, required this.positionY, required this.onCollect, required this.onGameOver});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: positionY,
      left: positionX,
      child: GestureDetector(
        onPanUpdate: (details){
          onCollect(details.localPosition.dx);
        },
        child: Container(
          width: 50,
          height: 50,
          color: Colors.red, // Player color
        ),
      ),
    );
  }
}
