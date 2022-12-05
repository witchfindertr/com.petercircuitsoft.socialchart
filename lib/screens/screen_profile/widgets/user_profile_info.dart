import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialchart/models/model_user_data.dart';

class UserProfileInfo extends StatelessWidget {
  const UserProfileInfo({
    super.key,
    this.userData,
  });
  final UserDataModel? userData;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userData?.displayName ?? "Undefined",
              style: Theme.of(context).textTheme.headline5,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              userData?.introductionMessage ?? "아직 소개 글이 없습니다.",
              style: Theme.of(context).textTheme.bodyText2,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            Text(
              userData != null
                  ? "${DateFormat('yyyy년 MM월 dd일 HH시 mm분 ss초').format(userData!.createdAt.toDate())}에 계정 생성됨."
                  : "로딩중",
              style: Theme.of(context).textTheme.caption,
            ),
            Text(
              userData?.userUrl ?? "등록한 웹 주소가 없습니다.",
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
