import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialchart/customWidgets/MainAppBar.dart';

class ScreenExplore extends StatelessWidget {
  const ScreenExplore({super.key});
  static const routeName = '/ScreenExplore';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(appBar: AppBar(), title: "Explore"),
      body: Center(child: Text("Explore Screen")),
    );
  }
}
