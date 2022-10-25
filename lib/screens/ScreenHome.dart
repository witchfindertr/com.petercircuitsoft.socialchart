import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialchart/customWidgets/GradientMask.dart';
import 'package:socialchart/customWidgets/InsightCard/InsightCard.dart';

List<int> test = [1, 2, 3, 4, 5, 6, 7];

TextStyle appBarTitle = TextStyle(
  fontSize: 25,
  fontWeight: FontWeight.bold,
  foreground: Paint()
    ..shader = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[
        Colors.pinkAccent,
        Colors.deepPurpleAccent,
        Colors.red
        //add more color here.
      ],
    ).createShader(
      Rect.fromLTWH(0.0, 0.0, 200.0, 100.0),
    ),
);

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          centerTitle: false,
          title: Text(
            "Social Chart",
            style: appBarTitle,
          ),
          actions: [
            TextButton(
              onPressed: () => {},
              child: LinearGradientMask(
                child: Icon(Icons.search, size: 30),
              ),
            ),
          ],
        ),
        body: Container(
            color: Colors.black12,
            child: ListView.builder(
              itemCount: test.length,
              itemBuilder: (context, index) {
                return InsightCard();
              },
            )));
  }
}
