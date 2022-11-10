import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/screens/screen_insightcard/widgets/insightcard/insightcard.dart';
import 'package:socialchart/custom_widgets/main_appbar.dart';
import 'package:socialchart/custom_widgets/user_profile.dart';
import 'package:socialchart/screens/screen_insightcard/widgets/insightcard/insightcard_list.dart';
import 'package:socialchart/screens/screen_profile/screen_profile_controller.dart';

List<int> test = [1, 2, 3, 4, 5, 6, 7];

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
            () => Text(controller.userData.value != null
                ? (controller.userId == firebaseAuth.currentUser!.uid
                    ? '내 프로필'
                    : '${controller.userData.value?.displayName}님 프로필')
                : 'Undefined'),
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
                userData: controller.userData.value,
              ),
            )),
      ),
    );
  }
}
