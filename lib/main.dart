import 'package:flutter/material.dart';
import 'homepage.dart';

void main() {
  runApp(const game());
}

class game extends StatelessWidget {
  const game({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
