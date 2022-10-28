import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialchart/controllers/userProfileController.dart';
import 'package:socialchart/navigators/NavigationTree.dart';
import 'package:socialchart/screens/ScreenProfile.dart';

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
            print("tab!!");
            Get.toNamed("/ScreenProfile",
                id: 1,
                arguments:
                    ScreenProfileArgs(userId: "WwpkY0hvXrfWtxNhaUthCza5jFL2"));
            // Navigator.pushNamed(context, "/ScreenProfile",
            //     arguments:
            //         ScreenProfileArgs(userId: "yscSk8qztTUrtN26UpsGHU2qSA12"));
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
