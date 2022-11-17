import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/navigators/navigator_main/navigator_main_controller.dart';
import './widgets/user_profile.dart';
import 'package:socialchart/custom_widgets/main_sliver_appbar.dart';
import 'package:socialchart/custom_widgets/insightcard/insightcard_list.dart';
import 'package:socialchart/screens/screen_profile/screen_profile_controller.dart';

class ScreenProfile extends GetView<ScreenProfileController> {
  const ScreenProfile({super.key, required this.navKey});
  final NavKeys navKey;
  static const routeName = "/ScreenProfile";

  @override
  // TODO: implement tag
  String? get tag => navKey?.name;

  @override
  Widget build(BuildContext context) {
    NavigatorMainController.to.scrollControllerMap.addEntries(
        {'${navKey.index}$routeName': controller.scrollController}.entries);
    return SafeArea(
      child: Scaffold(
        body: InsightCardList(
          scrollController: controller.scrollController,
          sliverAppBar: Obx(
            () => MainSliverAppbar(
                searchButtonVisible: false,
                titleText: controller.isCurrentUser
                    ? '내 프로필'
                    : '${controller.userData?.displayName ?? ""}님의 프로필'),
          ),
          scrollToTopEnable: true,
          navKey: navKey,
          userId: controller.userId,
          header: Obx(
            () => UserProfile(
              isCurrentUser: controller.isCurrentUser,
              userData: controller.userData,
              userId: controller.userId,
            ),
          ),
        ),
      ),
    );
  }
}
