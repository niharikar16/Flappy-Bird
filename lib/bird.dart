import 'package:flutter/material.dart';

class MyBird extends StatelessWidget {
  // const MyBird({Key? key}) : super(key: key);
  final birdY;
  final double birdWidth;
  final double birdheight;

  MyBird({this.birdY, required this.birdWidth, required this.birdheight});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0, (2 * birdY + birdheight) / (2 - birdheight)),
      child: Image.asset(
        'lib/images/bird.png',
        width: MediaQuery.of(context).size.height * birdWidth / 2,
        height: MediaQuery.of(context).size.height * birdheight / 2,
        fit: BoxFit.fill,
      ),
    );
  }
}
