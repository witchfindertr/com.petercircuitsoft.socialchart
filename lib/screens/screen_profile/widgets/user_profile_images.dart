import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/controllers/auth_controller.dart';
import 'package:socialchart/custom_widgets/user_avata.dart';
import 'package:socialchart/models/model_user_data.dart';
import 'package:socialchart/navigators/navigator_main/navigator_main_controller.dart';
import 'package:socialchart/screens/modal_screen_profile_setting/modal_screen_profile_setting.dart';
import 'package:socialchart/screens/modal_screen_profile_setting/modal_screen_profile_setting_binding.dart';
import 'package:socialchart/screens/screen_account_setting/screen_account_setting.dart';
//todo for the test
import 'package:socialchart/utils/developmentHelp.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:validators/validators.dart';

class UserProfileImages extends StatelessWidget {
  const UserProfileImages({
    super.key,
    this.userData,
    required this.userId,
    this.isCurrentUser = false,
  });

  final ModelUserData? userData;
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
                      child: isURL(userData?.backgroundImageUrl)
                          ? CachedNetworkImage(
                              imageUrl: userData!.backgroundImageUrl!,
                              fit: BoxFit.fitWidth,
                            )
                          : Container(color: Colors.grey)),
                ),
                onTap: () {
                  Get.to(
                    fullscreenDialog: true,
                    () => GestureDetector(
                      child: Hero(
                        tag: userId + "background",
                        child: SizedBox(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.2,
                          child: isURL(userData?.backgroundImageUrl)
                              ? CachedNetworkImage(
                                  imageUrl: userData!.backgroundImageUrl!,
                                  fit: BoxFit.fitWidth,
                                )
                              : Container(color: Colors.grey),
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
                  margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  width: MediaQuery.of(context).size.height * 0.1,
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: GestureDetector(
                      child: Hero(
                        tag: userId + "image",
                        child: SizedBox(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.2,
                          child: CircularPaddedAvatar(
                            radius: 48,
                            backgroundImage: isURL(userData?.profileImageUrl)
                                ? CachedNetworkImageProvider(
                                    userData!.profileImageUrl!)
                                : null,
                            child: isURL(userData?.profileImageUrl)
                                ? null
                                : randomAvatar(userId),
                          ),
                        ),
                      ),
                      onTap: () {
                        Get.to(
                          fullscreenDialog: true,
                          () => GestureDetector(
                            child: Hero(
                              tag: userId + "image",
                              child: SizedBox(
                                width: double.infinity,
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                child: isURL(userData?.profileImageUrl)
                                    ? CachedNetworkImage(
                                        imageUrl: userData!.profileImageUrl!)
                                    : randomAvatar(userId),
                              ),
                            ),
                            onTap: () => Get.back(),
                          ),
                        );
                      }),
                ),
                isCurrentUser
                    ? Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () {
                                Get.to(
                                    duration: Duration(milliseconds: 500),
                                    fullscreenDialog: true,
                                    binding: ModalScreenProfileSettingBinding(
                                        userId: userId, userData: userData!),
                                    () => ModalScreenProfileSetting());
                              },
                              child: Text("프로필 수정"),
                              style: ButtonStyle(
                                alignment: Alignment.bottomCenter,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Get.toNamed(ScreenAccountSetting.routeName,
                                    id: NavKeys.profile.index,
                                    arguments: userData);
                              },
                              child: Text("설정"),
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