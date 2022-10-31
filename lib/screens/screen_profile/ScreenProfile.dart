import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialchart/navigators/navigator_constant.dart';
import 'package:socialchart/screens/screen_insightcard/widgets/insightcard/insightcard.dart';
import 'package:socialchart/custom_widgets/main_appbar.dart';
import 'package:socialchart/custom_widgets/user_profile.dart';
import 'package:socialchart/screens/screen_profile/ScreenProfileController.dart';

List<int> test = [1, 2, 3, 4, 5, 6, 7];

class ScreenProfile extends GetView<ScreenProfileController> {
  ScreenProfile({super.key, this.userId, this.navKey});
  String? userId;
  final NavKeys? navKey;
  static const routeName = "/ScreenProfile";

  @override
  // TODO: implement tag
  String? get tag => navKey?.name;

  @override
  Widget build(BuildContext context) {
    controller.userId = userId;
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
                return Column(children: [
                  Obx(() {
                    return UserProfile(
                      userData: controller.userData.value,
                    );
                  }),
                ]);
                break;

              default:
                return InsightCard(navKey: navKey);
                break;
            }
          }),
        ),
      ),
    );
  }
}
