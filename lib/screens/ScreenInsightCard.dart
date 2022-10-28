import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenInsightCard extends StatelessWidget {
  const ScreenInsightCard({super.key});
  static const routeName = "/ScreenInsightCard";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("InsightCard Screen")),
      body: Center(child: Text("InsightCard Screen")),
    );
  }
}
