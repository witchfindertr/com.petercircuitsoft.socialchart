import 'package:flutter/material.dart';
import 'package:socialchart/custom_widgets/user_interested_chart.dart';
import 'package:socialchart/models/model_user_data.dart';
import 'user_profile_images.dart';
import './user_profile_info.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({
    super.key,
    required this.userData,
    required this.userId,
    this.isCurrentUser = false,
  });
  final ModelUserData? userData;
  final String? userId;
  final bool isCurrentUser;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).scaffoldBackgroundColor,
      margin: EdgeInsets.all(0),
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(0)),
      ),
      child: Column(
        children: [
          UserProfileImages(
            userData: userData,
            userId: userId!,
            isCurrentUser: isCurrentUser,
          ),
          UserProfileInfo(
            userData: userData,
          ),
          Divider(),
          Container(
              margin: EdgeInsets.all(10),
              width: double.infinity,
              child: Text(
                isCurrentUser ? "내 관심 차트" : '${userData?.displayName}님의 관심 차트',
                style: Theme.of(context).textTheme.headline5,
              )),
          UserInterestedChart(userInterestedCharts: []),
          Divider(),
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(10),
            child: Text(
              isCurrentUser
                  ? "내 인사이트 카드"
                  : '${userData?.displayName}님의 인사이트 카드',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
        ],
      ),
    );
  }
}
