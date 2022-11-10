import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:socialchart/app_constant.dart';
import 'package:socialchart/models/model_user_data.dart';
import 'package:socialchart/navigators/navigator_main/navigator_main_controller.dart';

class InsightCardAuthor extends StatelessWidget {
  const InsightCardAuthor({
    super.key,
    this.userData,
    required this.cardId,
    required this.userId,
    required this.elapsed,
    this.navKey,
  });
  final NavKeys? navKey;
  final UserDataModel? userData;
  final String userId;
  final String cardId;
  final String elapsed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: ListTile(
        contentPadding: EdgeInsets.all(0),
        minLeadingWidth: 50,
        horizontalTitleGap: 5,
        dense: true,
        leading: GestureDetector(
          child: Container(
            width: 48,
            height: 48,
            alignment: Alignment.center,
            child: const CircleAvatar(radius: 30),
          ),
          onTap: () {
            if (userId != firebaseAuth.currentUser!.uid) {
              Get.toNamed(
                "/ScreenProfile",
                id: navKey?.index,
                arguments: userId,
              );
            } else {
              MainNavigatorController.to.currentIndex = NavKeys.profile;
              Get.toNamed('/', id: NavKeys.profile.index);
            }
          },
        ),
        title: Text(
          userData != null ? userData!.displayName! : "Undefined",
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          elapsed,
        ),
        trailing: PopupMenuButton(
          position: PopupMenuPosition.under,
          splashRadius: 1,
          itemBuilder: (BuildContext context) {
            return userId != firebaseAuth.currentUser?.uid
                ? myMenu(context)
                : userMenu(context);
          },
        ),
      ),
    );
  }

  userMenu(BuildContext context) {
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
      ),
    ];
  }

  myMenu(BuildContext context) {
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
      ),
    ];
  }
}
