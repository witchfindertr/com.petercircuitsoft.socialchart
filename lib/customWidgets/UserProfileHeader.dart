import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:socialchart/controllers/reportController.dart';
import 'package:socialchart/controllers/userProfileController.dart';
//todo for the test
import 'package:socialchart/utils/developmentHelp.dart';

class UserProfileHeader extends StatelessWidget {
  const UserProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.25,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.2,
              child: Image.network(
                developmentHelper.randomPictureUrl(),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.15,
            left: 0,
            right: 0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  width: MediaQuery.of(context).size.height * 0.1,
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child:
                          Image.network(developmentHelper.randomPictureUrl())),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () => FirebaseAuth.instance.signOut(),
                        child: Text("프로필 수정"),
                        style: ButtonStyle(
                          alignment: Alignment.bottomCenter,
                        ),
                      ),
                      TextButton(
                        onPressed: () => {},
                        child: Text("계정 설정"),
                        style: ButtonStyle(
                          alignment: Alignment.bottomCenter,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
