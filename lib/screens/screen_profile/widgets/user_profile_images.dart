import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/custom_widgets/user_avata.dart';
import 'package:socialchart/models/model_user_data.dart';
import 'package:socialchart/screens/modal_screen_profile_setting/modal_screen_profile_setting.dart';
import 'package:socialchart/screens/modal_screen_profile_setting/modal_screen_profile_setting_binding.dart';
import 'package:socialchart/screens/screen_account_setting/screen_account_setting.dart';
//todo for the test
import 'package:random_avatar/random_avatar.dart';
import 'package:socialchart/screens/screen_profile/screen_profile_controller.dart';
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
    var userImageContainerHeight = MediaQuery.of(context).size.width * 9 / 16;
    return GetBuilder(
      init: ScreenProfileController(userId: userId),
      tag: userId,
      builder: (controller) {
        return Container(
          width: double.infinity,
          height: userImageContainerHeight,
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
                          height: userImageContainerHeight,
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
                            child: Container(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              // width: double.infinity,
                              height: MediaQuery.of(context).size.height,
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
                // top: userImageContainerHeight * 1.8 / 3,
                left: 0,
                right: 0,
                bottom: userImageContainerHeight / 20,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.height * 0.1,
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: GestureDetector(
                            child: Hero(
                              tag: userId + "image",
                              child: SizedBox(
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height,
                                child: CircularPaddedAvatar(
                                  radius: 48,
                                  backgroundImage:
                                      isURL(userData?.profileImageUrl)
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
                                    child: Container(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      height:
                                          MediaQuery.of(context).size.height,
                                      child: isURL(userData?.profileImageUrl)
                                          ? CachedNetworkImage(
                                              imageUrl:
                                                  userData!.profileImageUrl!)
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
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CupertinoButton(
                                    color: Theme.of(context)
                                        .secondaryHeaderColor
                                        .withOpacity(0.8),
                                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    onPressed: () {
                                      Get.to(
                                          duration: Duration(milliseconds: 500),
                                          fullscreenDialog: true,
                                          binding:
                                              ModalScreenProfileSettingBinding(
                                                  userId: userId,
                                                  userData: userData!),
                                          () => ModalScreenProfileSetting());
                                    },
                                    child: Text(
                                      "프로필 수정",
                                      style: Theme.of(context).textTheme.button,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  CupertinoButton(
                                    color: Theme.of(context)
                                        .secondaryHeaderColor
                                        .withOpacity(0.8),
                                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    onPressed: () {
                                      Get.toNamed(
                                          ScreenAccountSetting.routeName,
                                          id: NavKeys.profile.index,
                                          arguments: userData);
                                    },
                                    child: Text(
                                      "설정",
                                      style: Theme.of(context).textTheme.button,
                                    ),
                                    // style: ButtonStyle(
                                    //   alignment: Alignment.bottomCenter,
                                    // ),
                                  ),
                                ],
                              ),
                            )
                          : CupertinoButton(
                              color: Theme.of(context)
                                  .secondaryHeaderColor
                                  .withOpacity(0.8),
                              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              child: Obx(() => Text(
                                  controller.amIfollowing ? "팔로우 취소" : "팔로우",
                                  style: Theme.of(context).textTheme.button)),
                              onPressed: () {
                                controller.toggleFollowButton(userId);
                              },
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
