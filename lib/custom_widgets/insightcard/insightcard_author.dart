import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:socialchart/app_constant.dart';
import 'package:socialchart/controllers/user_data_fetcher.dart';
import 'package:socialchart/custom_widgets/insightcard/insightcard_author_controller.dart';
import 'package:socialchart/custom_widgets/insightcard/insightcard_controller.dart';
import 'package:socialchart/custom_widgets/user_avata.dart';
import 'package:socialchart/models/model_user_insightcard.dart';
import 'package:socialchart/navigators/navigator_main/navigator_main_controller.dart';
import 'package:socialchart/screens/modal_screen_report/modal_screen_report.dart';
import 'package:socialchart/screens/modal_screen_report/modal_screen_report_binding.dart';
import 'package:socialchart/screens/modal_screen_write_modify/modal_screen_write_modify.dart';
import 'package:socialchart/screens/modal_screen_write_modify/modal_screen_write_modify_binding.dart';
import 'package:socialchart/screens/screen_profile/screen_profile.dart';
import 'package:timeago/timeago.dart' as timeago;

class InsightCardAuthor extends StatelessWidget {
  const InsightCardAuthor({
    super.key,
    required this.routeName,
    required this.cardId,
    required this.cardData,
    // required this.elapsed,
    this.navKey,
  });
  final NavKeys? navKey;
  final String routeName;
  final ModelInsightCard cardData;
  final String cardId;
  // final String elapsed;

  @override
  Widget build(BuildContext context) {
    var user = Get.put(UserDataFetcher(userId: cardData.author.id),
        tag: cardData.author.id);
    return GetBuilder(
        init: InsightCardAuthorController(
            cardId: cardId, cardData: cardData, cardTag: cardId + routeName),
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
                  if (cardData.author.id != currentUserId) {
                    Get.toNamed(
                      ScreenProfile.routeName,
                      id: navKey?.index,
                      arguments: cardData.author.id,
                      preventDuplicates: true,
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
        value: "reportCard",
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '????????? ??????',
            ),
            Icon(CupertinoIcons.exclamationmark_triangle),
          ],
        ),
        onTap: () => Get.to(() => ModalScreenReport(),
            binding: ModalScreenReportBinding(cardId: cardId),
            fullscreenDialog: true),
      ),
      PopupMenuItem<String>(
        textStyle: Theme.of(context).textTheme.bodyMedium,
        value: "blockCard",
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '????????? ?????????',
            ),
            Icon(CupertinoIcons.eye_slash),
          ],
        ),
        onTap: () => controller.blockCard(cardId).then((value) {
          if (value) {
          } else {
            Get.snackbar("??????", "?????? ??????f??? ???????????????.");
          }
        }),
      ),
      PopupMenuItem<String>(
        textStyle: Theme.of(context).textTheme.bodyMedium,
        value: "2",
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              controller.amIfollowing ? "????????? ??????" : "?????????",
            ),
            Icon(
              controller.amIfollowing
                  ? CupertinoIcons.person_badge_minus
                  : CupertinoIcons.person_badge_plus,
            ),
          ],
        ),
        onTap: () => controller.toggleFollowButton(cardData.author.id),
      ),
      PopupMenuItem<String>(
        textStyle: Theme.of(context).textTheme.bodyMedium,
        value: "blockUser",
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '????????? ??????',
            ),
            Icon(CupertinoIcons.hand_raised_slash),
          ],
        ),
        onTap: () async {
          controller.blockUser(cardData.author.id).then(
            (value) {
              if (value) {
                Get.snackbar(
                  "??????",
                  "?????? ???????????? ??????????????????.",
                  animationDuration: 500.milliseconds,
                  mainButton: TextButton(
                    onPressed: () {
                      userDB.unBlockUser(cardData.author.id).then(
                        (value) {
                          if (value) {
                            Get.back(closeOverlays: true);
                            Get.snackbar(
                              "??????",
                              "?????????????????????.",
                              animationDuration: 500.milliseconds,
                            );
                          }
                        },
                      );
                    },
                    child: Text("??????"),
                  ),
                  messageText: Row(
                    children: [
                      Text("?????? ???????????? ??????????????????."),
                    ],
                  ),
                );
              } else {
                Get.snackbar("??????", "????????? ????????? ???????????????.");
              }
            },
          );
        },
      ),
      PopupMenuItem<String>(
        textStyle: Theme.of(context).textTheme.bodyMedium,
        value: "dislikeCard",
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '????????????!',
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
        value: "modifyCard",
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '?????? ??????',
            ),
            SizedBox(
              width: 30,
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
            Get.find<InsightCardController>(tag: cardId + routeName)
                .refreshFunction!();
        },
      ),
      PopupMenuItem<String>(
        textStyle: Theme.of(context).textTheme.bodyMedium,
        value: "deleteCard",
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '?????? ??????',
            ),
            SizedBox(
              width: 30,
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
