import 'package:flutter/material.dart';

class Player extends StatelessWidget {
  final double positionX;

  Player({required this.positionX});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 100,
      left: positionX,
      child: Container(
        width: 50,
        height: 50,
        color: Colors.red, // Player character
      ),
    );
  }
}
