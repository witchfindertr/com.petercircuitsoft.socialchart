import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialchart/controllers/userProfileController.dart';

class UserProfileInfo extends StatelessWidget {
  const UserProfileInfo({super.key});

  @override
  Widget build(BuildContext context) {
    UserProfileController userProfile =
        Get.find<UserProfileController>(tag: "UserProfile");
    return Container(
        width: double.infinity,
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "우리와이프짱짱맨",
              style: Theme.of(context).textTheme.headline5,
            ),
            Text(
              "“길동은 아버지를 아버지라 못하고 형을 형이라 부르지 못하니 자신이 천하게 난 것을 스스로 가슴 깊이 한탄하였다.”",
              style: Theme.of(context).textTheme.bodyText2,
            ),
            Obx(() {
              return Text(
                userProfile.userData.value != null
                    ? "${userProfile.userData.value!.createdAt.toDate().toString()}에 계정 생성됨."
                    : "로딩중",
                style: Theme.of(context).textTheme.caption,
              );
            }),
            Text(
              "🔗petercircuitsoft.com",
              style: Theme.of(context).textTheme.caption,
            ),
            Text(
              "팔로워: 2명",
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ));
  }
}
