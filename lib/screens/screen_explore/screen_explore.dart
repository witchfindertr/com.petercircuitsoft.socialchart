import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialchart/custom_widgets/main_appbar.dart';
import 'package:socialchart/app_constant.dart';

class ScreenExplore extends StatelessWidget {
  const ScreenExplore({super.key, this.navKey});
  final NavKeys? navKey;
  static const routeName = '/ScreenExplore';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(appBar: AppBar(), title: "Explore"),
      body: Center(child: Text("Explore Screen")),
    );
  }
}
