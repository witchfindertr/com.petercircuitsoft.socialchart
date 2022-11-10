import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:socialchart/app_constant.dart';
import 'package:socialchart/models/model_user_data.dart';

class InsightCardAuthor extends StatelessWidget {
  const InsightCardAuthor({
    super.key,
    this.userData,
    required this.userId,
    required this.elapsed,
    this.navKey,
  });
  final NavKeys? navKey;
  final UserDataModel? userData;
  final String userId;
  final String elapsed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: ListTile(
        contentPadding: EdgeInsets.all(0),
        minLeadingWidth: 50,
        horizontalTitleGap: 5,
        leading: GestureDetector(
          behavior: HitTestBehavior.translucent,
          child: Container(
            width: 48,
            height: 48,
            alignment: Alignment.center,
            child: const CircleAvatar(radius: 30),
          ),
          onTap: () {
            Get.toNamed(
              "/ScreenProfile",
              id: navKey?.index,
              arguments: userId,
            );
          },
        ),
        title: Text(userData != null ? userData!.displayName! : "Undefined"),
        subtitle: Text(elapsed),
        onTap: () => {Get.toNamed("/ScreenInsightCard", id: navKey?.index)},
      ),
    );
  }
}
