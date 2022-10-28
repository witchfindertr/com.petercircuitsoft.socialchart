import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenChart extends StatelessWidget {
  const ScreenChart({super.key});
  static const routeName = "/ScreenChart";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chart Screen")),
      body: Center(child: Text("Chart Screen")),
    );
  }
}
