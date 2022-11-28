import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialchart/controllers/auth_controller.dart';
import 'package:socialchart/models/model_user_data.dart';
//todo for the test
import 'package:socialchart/utils/developmentHelp.dart';

class UserProfileImages extends StatelessWidget {
  const UserProfileImages({
    super.key,
    this.userData,
    required this.userId,
    this.isCurrentUser = false,
  });

  final UserDataModel? userData;
  final String userId;
  final bool isCurrentUser;

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
            //userBackgroundImage
            child: GestureDetector(
                child: Hero(
                  tag: userId + "background",
                  child: SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: CachedNetworkImage(
                      imageUrl:
                          "https://i.picsum.photos/id/274/300/300.jpg?hmac=ONC6yV48qfvyeyXwAe7QE7b08QXABIQJjwT5chzImAg",
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                onTap: () {
                  Get.to(
                    () => GestureDetector(
                      child: Hero(
                        tag: userId + "background",
                        child: SizedBox(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.2,
                          child: CachedNetworkImage(
                            imageUrl:
                                "https://i.picsum.photos/id/274/300/300.jpg?hmac=ONC6yV48qfvyeyXwAe7QE7b08QXABIQJjwT5chzImAg",
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                      onTap: () => Get.back(),
                    ),
                  );
                }),
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
                    child: GestureDetector(
                        child: Hero(
                          tag: userId + "image",
                          child: SizedBox(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.2,
                            child: CachedNetworkImage(
                              imageUrl:
                                  "https://i.picsum.photos/id/442/200/200.jpg?hmac=S-yNCNr30GK97ulUYoey_Fh2-czIf7YnNgcKp7zrEoE",
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                        onTap: () {
                          Get.to(
                            () => GestureDetector(
                              child: Hero(
                                tag: userId + "image",
                                child: SizedBox(
                                  width: double.infinity,
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        "https://i.picsum.photos/id/442/200/200.jpg?hmac=S-yNCNr30GK97ulUYoey_Fh2-czIf7YnNgcKp7zrEoE",
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              ),
                              onTap: () => Get.back(),
                            ),
                          );
                        }),
                  ),
                ),
                isCurrentUser
                    ? Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () => AuthController.to.signOut(),
                              child: Text("프로필 수정"),
                              style: ButtonStyle(
                                alignment: Alignment.bottomCenter,
                              ),
                            ),
                            TextButton(
                              onPressed: () => showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Container();
                                },
                              ),
                              child: Text("계정 설정"),
                              style: ButtonStyle(
                                alignment: Alignment.bottomCenter,
                              ),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
