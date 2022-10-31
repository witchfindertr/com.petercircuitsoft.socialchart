import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialchart/navigators/navigator_constant.dart';
import 'package:socialchart/screens/screen_insightcard/screen_insightcard_controller.dart';

class ScreenInsightCard extends GetView<ScreenInsightCardController> {
  const ScreenInsightCard({super.key, required this.navKey});

  final NavKeys navKey;

  @override
  // TODO: implement tag
  String? get tag => navKey.name;

  static const routeName = "/ScreenInsightCard";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("InsightCard Screen")),
      body: Center(child: Text("tag: ${tag}")),
    );
  }
}
