import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/custom_widgets/appbar_buttons.dart';
import 'package:socialchart/custom_widgets/insightcard/insightcard.dart';
import 'package:socialchart/custom_widgets/insightcard/insightcard_controller.dart';
import 'package:socialchart/models/model_user_insightcard.dart';
import 'package:socialchart/navigators/navigator_main/navigator_main_controller.dart';
import './widgets/user_profile.dart';
import 'package:socialchart/custom_widgets/main_sliver_appbar.dart';
import 'package:socialchart/screens/screen_profile/screen_profile_controller.dart';

class ScreenProfile extends GetView<ScreenProfileController> {
  const ScreenProfile({super.key, required this.navKey, required this.userId});
  final NavKeys navKey;
  final String userId;
  static const routeName = "/ScreenProfile";

  @override
  // TODO: implement tag
  String? get tag => userId;

  @override
  Widget build(BuildContext context) {
    NavigatorMainController.to.scrollControllerMap.addEntries(
        {'${navKey.index}$routeName': controller.scrollController}.entries);
    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () => Future.sync(() {
            controller.pagingController.refresh();
            controller.fetchProfileUserData();
          }),
          child: CustomScrollView(
            controller: controller.scrollController,
            slivers: [
              Obx(
                () => MainSliverAppbar(
                  titleText: controller.isCurrentUser
                      ? '내 프로필'
                      : '${controller.userData?.displayName ?? ""}님의 프로필',
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  actions: [
                    appbarSearchButton(
                      //todo get to search page
                      () => print("search button pressed"),
                    )
                  ],
                ),
              ),
              Obx(
                () => SliverToBoxAdapter(
                  child: UserProfile(
                    userData: controller.userData,
                    userId: controller.userId,
                    isCurrentUser: controller.isCurrentUser,
                  ),
                ),
              ),
              PagedSliverList.separated(
                pagingController: controller.pagingController,
                separatorBuilder: (context, index) {
                  return Container(
                    color: Theme.of(context).backgroundColor,
                    height: 8,
                  );
                },
                builderDelegate: PagedChildBuilderDelegate<
                    QueryDocumentSnapshot<ModelInsightCard>>(
                  itemBuilder: (context, item, index) {
                    return GetBuilder(
                      init: InsightCardController(
                        cardId: item.id,
                        cardInfo: item.data(),
                      ),
                      tag: item.id + routeName,
                      builder: (controller) {
                        return InsightCard(
                          routeName: routeName,
                          navKey: navKey,
                          showHeader: true,
                          cardId: item.id,
                          cardData: item.data(),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        // body: InsightCardList(
        //   scrollController: controller.scrollController,
        //   sliverAppBar: Obx(
        //     () => MainSliverAppbar(
        //         searchButtonVisible: false,
        //         titleText: controller.isCurrentUser
        //             ? '내 프로필'
        //             : '${controller.userData?.displayName ?? ""}님의 프로필'),
        //   ),
        //   scrollToTopEnable: true,
        //   navKey: navKey,
        //   userId: controller.userId,
        //   persistentHeader: Obx(
        //     () => SliverPersistentHeader(
        //         delegate: ProfilePersistentHeaderDelegate(
        //       userData: controller.userData,
        //       userId: controller.userId,
        //       isCurrentUser: controller.isCurrentUser,
        //     )),
        //   ),
        //   // persistentHeader: Obx(
        //   //   () => UserProfile(
        //   //     isCurrentUser: controller.isCurrentUser,
        //   //     userData: controller.userData,
        //   //     userId: controller.userId,
        //   //   ),
        //   // ),
        // ),
      ),
    );
  }
}
