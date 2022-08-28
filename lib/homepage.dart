import 'dart:async';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:game/barrier.dart';
import 'package:game/bird.dart';
import 'package:game/main.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double birdY = 0;
  double time = 0;
  double height = 0;
  double initialHeight = birdY;
  double birdWidth = 0.1;
  double birdheight = 0.1;

  bool gameStarted = false;

  static List<double> barrierX = [2, 2 + 1.5];
  static double barrierWidth = 0.5;
  List<List<double>> barrierHeight = [
    [0.6, 0.4],
    [0.4, 0.6]
  ]

  void jump() {
    setState(() {
      time = 0;
      initialHeight = birdY;
    });
  }

  void startGame() {
    gameStarted = true;
    Timer.periodic(Duration(milliseconds: 10), (timer) {
      time += 0.05;
      height = -4.9 * time * time + 3.5* time;
      setState(() {
        birdY = initialHeight - height;
      });

      //if the bird died
      if (IsBirdDead()) {
        timer.cancel();
        // gameStarted = false;
        _showDialog();
      }
      moveMap();

      //keeps the timer going 
      time += 0.01;

    });
  }



  void moveMap()
  {
    for(int i = 0; i< barrierX.length ; i++)
    {
      setState(() {
        barrierX[i] -=0.005;
      });
      if(barrierX[i] < -1.5)
      {
        barrierX[i] +=3 ;
      }
    }
  }

  bool IsBirdDead() {
    if (birdY < -1 || birdY > 1) {
      return true;
    } else
      return false;
  }

  void _showDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext) {
          return AlertDialog(
            backgroundColor: Colors.brown,
            title: Center(
                child: Text(
              "G A M E  O V E R",
              style: TextStyle(color: Colors.white),
            )),
            actions: [
              GestureDetector(
                onTap: resetGame,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    padding: EdgeInsets.all(7),
                    color: Colors.white,
                    child: Text(
                      'PLAY AGAIN',
                      style: TextStyle(color: Colors.brown),
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }

  void resetGame() {
    Navigator.pop(context);
    setState(() {
      birdY = 0;
      gameStarted = false;
      time = 0;
      initialHeight = birdY;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (gameStarted) {
          jump();
        } else {
          startGame();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
          Expanded(
              flex: 3,
              child: Container(color: Colors.blue,
                child: Stack(
                  children: [
                    AnimatedContainer(
                      alignment: Alignment(0, birdY),
                      duration: Duration(milliseconds: 0),
                      color: Colors.blue,
                      child: MyBird(),
                    ),
                    Container(
                      alignment: Alignment(0, -0.25),
                      child: gameStarted
                          ? Text("")
                          : Text(
                              "T A P   T O   P L A Y",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(barXone, 1.1),
                      duration: Duration(milliseconds: 0),
                      child: Mybarrier(
                        barrierSize: 200.0,
                      ),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(barXone, -1.1),
                      duration: Duration(milliseconds: 0),
                      child: Mybarrier(
                        barrierSize: 220.0,
                      ),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(barXtwo, 1.1),
                      duration: Duration(milliseconds: 0),
                      child: Mybarrier(
                        barrierSize: 150.0,
                      ),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(barXtwo, -1.1),
                      duration: Duration(milliseconds: 0),
                      child: Mybarrier(
                        barrierSize: 250.0,
                      ),
                    )
                  ],
                ),
              )),
          Container(
            height: 15,
            color: Colors.green,
          ),
          Expanded(
              child: Container(
            color: Colors.brown,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "SCORE",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "0",
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "HIGH SCORE",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("0",
                        style: TextStyle(color: Colors.white, fontSize: 30)),
                  ],
                )
              ],
            ),
          )),
        ]),
      ),
    );
  }
}
  