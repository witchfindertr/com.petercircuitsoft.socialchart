import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:socialchart/custom_widgets/user_interested_chart.dart';
import 'package:socialchart/custom_widgets/user_profile_header.dart';
import 'package:socialchart/custom_widgets/user_profile_info.dart';
import 'package:socialchart/models/model_user_data.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key, this.userData});
  final UserData? userData;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(0),
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(0)),
      ),
      child: Column(
        children: [
          UserProfileHeader(),
          UserProfileInfo(
            userData: userData,
          ),
          Divider(),
          Container(
              margin: EdgeInsets.all(10),
              width: double.infinity,
              child: Text(
                "내 관심 차트",
                style: Theme.of(context).textTheme.headline5,
              )),
          UserInterestedChart(userInterestedCharts: []),
          Divider(),
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(10),
            child:
                Text("내 인사이트 카드", style: Theme.of(context).textTheme.headline5),
          ),
        ],
      ),
    );
  }
}
