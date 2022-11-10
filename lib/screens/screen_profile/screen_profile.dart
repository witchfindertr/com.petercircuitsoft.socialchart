import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialchart/app_constant.dart';

import './widgets/user_profile.dart';
import 'package:socialchart/custom_widgets/insightcard/insightcard_list.dart';
import 'package:socialchart/screens/screen_profile/screen_profile_controller.dart';

class ScreenProfile extends GetView<ScreenProfileController> {
  const ScreenProfile({super.key, this.navKey});
  final NavKeys? navKey;
  static const routeName = "/ScreenProfile";

  @override
  // TODO: implement tag
  String? get tag => navKey?.name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Obx(
            () => Text(controller.isCurrentUser
                ? '내 프로필'
                : '${controller.userData?.displayName}님의 프로필'),
          ),
          centerTitle: false),
      body: Container(
        color: Colors.black12,
        child: InsightCardList(
            scrollToTopEnable: true,
            navKey: navKey,
            userId: controller.userId,
            header: Obx(
              () => UserProfile(
                isCurrentUser: controller.isCurrentUser,
                userData: controller.userData,
                userId: controller.userId,
              ),
            )),
      ),
    );
  }
}
