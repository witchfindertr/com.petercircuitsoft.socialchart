import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialchart/custom_widgets/text_and_link.dart';
import 'package:socialchart/models/model_user_data.dart';
import 'package:socialchart/utils/etc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:validators/validators.dart';

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
              userData != null
                  ? "${DateFormat('yyyy년 MM월 dd일 HH시 mm분 ss초').format(userData!.createdAt.toDate())}에 계정 생성됨."
                  : "로딩중",
              style: Theme.of(context).textTheme.caption,
            ),
            Text(
              userData?.introductionMessage ?? "등록된 소개 글이 없습니다.",
              style: Theme.of(context).textTheme.bodyText2!.merge(
                  userData?.introductionMessage == null
                      ? TextStyle(color: Colors.grey)
                      : null),
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
            InkWell(
                child: Text(
                  "🔗${userData?.userUrl ?? "등록한 웹 주소가 없습니다."}",
                  style: Theme.of(context).textTheme.caption!.merge(
                      userData?.userUrl == null
                          ? TextStyle(color: Colors.grey)
                          : null),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
                onTap: () {
                  var userLink = completeLinkScheme(userData?.userUrl);
                  isURL(userLink) ? launchUrl(Uri.parse(userLink!)) : null;
                }),
            Text(
              "팔로워 ${userData?.followerCount ?? 0}명 / 팔로잉 ${userData?.followingCount ?? 0}명",
              style: Theme.of(context).textTheme.caption!.merge(
                  userData?.userUrl == null
                      ? const TextStyle(color: Colors.grey)
                      : null),
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
          ],
        ));
  }
}
