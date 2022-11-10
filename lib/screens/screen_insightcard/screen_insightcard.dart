import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/custom_widgets/insightcard/insightcard.dart';
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
      body: SingleChildScrollView(
        child: Obx(
          () => !controller.isLoading && controller.cardInfo != null
              ? InsightCard(
                  cardId: controller.cardId,
                  cardInfo: controller.cardInfo!,
                  navKey: navKey,
                  trimLine: 100)
              : Text("로딩 중이에요"),
        ),
      ),
      bottomSheet: Container(
        decoration: BoxDecoration(color: Colors.transparent),
        child: TextField(
          onTap: () => {},
          controller: controller.textController,
          decoration: InputDecoration(
            hintText: "댓글을 입력하세요.",
            contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ),
    );
  }
}
