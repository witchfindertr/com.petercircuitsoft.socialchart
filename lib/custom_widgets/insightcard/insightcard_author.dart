import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:socialchart/app_constant.dart';
import 'package:socialchart/controllers/user_data_fetcher.dart';
import 'package:socialchart/custom_widgets/insightcard/insightcard_author_controller.dart';
import 'package:socialchart/custom_widgets/insightcard/insightcard_controller.dart';
import 'package:socialchart/custom_widgets/user_avata.dart';
import 'package:socialchart/models/model_user_data.dart';
import 'package:socialchart/models/model_user_insightcard.dart';
import 'package:socialchart/navigators/navigator_main/navigator_main_controller.dart';
import 'package:socialchart/screens/modal_screen_write_modify/modal_screen_write_modify.dart';
import 'package:socialchart/screens/modal_screen_write_modify/modal_screen_write_modify_binding.dart';
import 'package:socialchart/screens/screen_profile/screen_profile.dart';
import 'package:timeago/timeago.dart' as timeago;

class InsightCardAuthor extends StatelessWidget {
  const InsightCardAuthor({
    super.key,
    required this.tag,
    required this.cardId,
    required this.cardData,
    // required this.elapsed,
    this.navKey,
  });
  final NavKeys? navKey;
  final String tag;
  final ModelInsightCard cardData;
  final String cardId;
  // final String elapsed;

  @override
  Widget build(BuildContext context) {
    var user = Get.put(UserDataFetcher(userId: cardData.author.id),
        tag: cardData.author.id);
    return GetBuilder(
        init: InsightCardAuthorController(
            cardId: cardId, cardData: cardData, cardTag: tag),
        tag: cardId,
        builder: (controller) {
          return Container(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: ListTile(
              contentPadding: const EdgeInsets.all(0),
              minLeadingWidth: 50,
              horizontalTitleGap: 5,
              dense: true,
              leading: GestureDetector(
                child: Container(
                  width: 48,
                  height: 48,
                  alignment: Alignment.center,
                  child: userAvatar(
                      url: user.userData?.profileImageUrl,
                      unique: cardData.author.id,
                      radius: 48),
                ),
                onTap: () {
                  print(Get.routing.current);
                  if (ModalRoute.of(context)!.settings.name ==
                      ScreenProfile.routeName) {
                    return;
                  }
                  if (cardData.author.id != firebaseAuth.currentUser!.uid) {
                    Get.toNamed(
                      ScreenProfile.routeName,
                      id: navKey?.index,
                      arguments: cardData.author.id,
                    );
                  } else {
                    NavigatorMainController.to.currentIndex = NavKeys.profile;
                    Get.toNamed('/', id: NavKeys.profile.index);
                  }
                },
              ),
              title: Text(
                user.userData != null
                    ? user.userData!.displayName!
                    : "Undefined",
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                timeago.format(cardData.createdAt.toDate(), locale: "kr"),
              ),
              trailing: PopupMenuButton(
                position: PopupMenuPosition.under,
                splashRadius: 1,
                itemBuilder: (BuildContext context) {
                  return cardData.author.id == firebaseAuth.currentUser?.uid
                      ? myMenu(context, controller)
                      : userMenu(context, controller);
                },
              ),
            ),
          );
        });
  }

  userMenu(BuildContext context, InsightCardAuthorController controller) {
    return <PopupMenuEntry<String>>[
      PopupMenuItem<String>(
        textStyle: Theme.of(context).textTheme.bodyMedium,
        value: "1",
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '게시물 신고',
            ),
            Icon(CupertinoIcons.exclamationmark_triangle),
          ],
        ),
      ),
      PopupMenuItem<String>(
        textStyle: Theme.of(context).textTheme.bodyMedium,
        value: "2",
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '게시물 가리기',
            ),
            Icon(CupertinoIcons.eye_slash),
          ],
        ),
      ),
      PopupMenuItem<String>(
        textStyle: Theme.of(context).textTheme.bodyMedium,
        value: "2",
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '팔로우/언팔',
            ),
            Icon(CupertinoIcons.person_crop_circle_badge_plus),
          ],
        ),
      ),
      PopupMenuItem<String>(
        textStyle: Theme.of(context).textTheme.bodyMedium,
        value: "2",
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '사용자 차단',
            ),
            Icon(CupertinoIcons.person_crop_circle_badge_xmark),
          ],
        ),
      ),
      PopupMenuItem<String>(
        textStyle: Theme.of(context).textTheme.bodyMedium,
        value: "2",
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '별로에요!',
            ),
            Icon(CupertinoIcons.hand_thumbsdown),
          ],
        ),
        onTap: () {
          controller.onDislikeMenuPress();
        },
      ),
    ];
  }

  myMenu(BuildContext context, InsightCardAuthorController controller) {
    return <PopupMenuEntry<String>>[
      PopupMenuItem<String>(
        textStyle: Theme.of(context).textTheme.bodyMedium,
        value: "1",
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '카드 수정',
            ),
            Icon(CupertinoIcons.pencil_ellipsis_rectangle),
          ],
        ),
        onTap: () async {
          var result = await Get.to(
            // duration: Duration(milliseconds: 500),
            fullscreenDialog: true,
            binding: ModalScreenWriteModifyBinding(
                cardId: cardId, cardData: cardData, chartId: cardData.chartId),
            () => ModalScreenWriteModify(
              navKey: navKey,
            ),
          );
          //todo make the code more cleaner
          if (result == "complete")
            Get.find<InsightCardController>(tag: tag).refreshFunction!();
        },
      ),
      PopupMenuItem<String>(
        textStyle: Theme.of(context).textTheme.bodyMedium,
        value: "2",
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '카드 삭제   ',
            ),
            Icon(CupertinoIcons.delete),
          ],
        ),
        onTap: () {
          controller.onDeletePress(context);
        },
      ),
    ];
  }
}
