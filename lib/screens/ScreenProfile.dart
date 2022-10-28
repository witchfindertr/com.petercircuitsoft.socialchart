import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialchart/controllers/userProfileController.dart';
import 'package:socialchart/customWidgets/InsightCard/InsightCard.dart';
import 'package:socialchart/customWidgets/MainAppBar.dart';
import 'package:socialchart/customWidgets/UserProfile.dart';

List<int> test = [1, 2, 3, 4, 5, 6, 7];

class ScreenProfileArgs {
  final String userId;
  ScreenProfileArgs({required this.userId});
}

class ScreenProfile extends StatefulWidget {
  const ScreenProfile({super.key, this.userId});
  static const routeName = '/ScreenProfile';
  final String? userId;

  @override
  State<ScreenProfile> createState() => _ScreenProfileState();
}

class _ScreenProfileState extends State<ScreenProfile> {
  // @override
  // void initState() {
  //   var userProfileController =
  //       Get.find<UserProfileController>(tag: "UserProfile");
  //   var authProfileContoller =
  //       Get.find<UserProfileController>(tag: "AuthProfile");
  //   print("Parameter: ${Get.parameters}");
  //   print("Arguments: ${Get.arguments}");
  //   // TODO: implement initState
  //   // print("Previous Route: ${Get.previousRoute}");
  //   if (widget.userId != null) {
  //     print("userId: ${widget.userId}");
  //     userProfileController.updateUser(widget.userId!);
  //   } else {
  //     authProfileContoller.updateUser(FirebaseAuth.instance.currentUser!.uid);
  //   }
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    // if (args != null) setUserId(args.userId);
    return Scaffold(
      appBar: MainAppBar(appBar: AppBar(), title: "Profile"),
      body: Container(
        color: Colors.black12,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: test.length + 1,
          itemBuilder: ((context, index) {
            switch (index) {
              case 0:
                return UserProfile();
                break;

              default:
                return const InsightCard();
                break;
            }
          }),
        ),
      ),
    );
  }
}
