import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialchart/customWidgets/InsightCard/InsightCard.dart';

List<int> test = [1, 2, 3, 4, 5, 6, 7];

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Home Screen")),
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
