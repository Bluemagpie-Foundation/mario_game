import 'package:flutter/material.dart';

class Collectible extends StatelessWidget {
  final double positionX;
  final double positionY;

  Collectible({required this.positionX, required this.positionY});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: positionX,
      bottom: positionY,
      child: Container(
        width: 50,
        height: 50,
        color: Colors.yellow, // Collectible color
      ),
    );
  }
}