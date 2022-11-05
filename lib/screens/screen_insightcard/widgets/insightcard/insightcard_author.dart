import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:socialchart/app_constant.dart';

class InsightCardAuthor extends StatelessWidget {
  const InsightCardAuthor({
    super.key,
    required this.author,
    required this.elapsed,
  });
  final String author;
  final String elapsed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          child: CircleAvatar(
            child: Text("avatar"),
          ),
          onTap: () {
            Get.toNamed(
              "/ScreenProfile",
              id: NavKeys.home.index,
              arguments: "yscSk8qztTUrtN26UpsGHU2qSA12",
            );
          },
        ),
        Column(
          children: [
            Text(author),
            Text(elapsed),
          ],
        ),
      ],
    );
  }
}
