import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialchart/custom_widgets/insightcard/insightcard_list.dart';
import 'package:socialchart/custom_widgets/main_appbar.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/custom_widgets/main_sliver_appbar.dart';
import 'package:socialchart/navigators/navigator_main/navigator_main_controller.dart';
import 'package:socialchart/screens/modal_screen_profile_setting/modal_screen_profile_setting_controller.dart';
import 'package:socialchart/screens/screen_explore/screen_explore_controller.dart';

class ModalScreenProfileSetting
    extends GetView<ModalScreenProfileSettingController> {
  const ModalScreenProfileSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("프로필 수정", style: TextStyle(color: Colors.black)),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [
          CupertinoButton(
            child: Text("저장"),
            onPressed: () => print("저장"),
            padding: EdgeInsets.zero,
          )
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.25,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              //userBackgroundImage
              child: GestureDetector(
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    // width: double.infinity,
                    // height: MediaQuery.of(context).size.height * 0.2,
                    child: Stack(children: [
                      Obx(
                        () => Container(
                          color: Colors.amber,
                          height: 200,
                          child: controller.backgroundImage.value != null
                              ? Image.file(
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  File(controller.backgroundImage.value!.path))
                              : CachedNetworkImage(
                                  width: double.infinity,
                                  imageUrl:
                                      "https://i.picsum.photos/id/274/300/300.jpg?hmac=ONC6yV48qfvyeyXwAe7QE7b08QXABIQJjwT5chzImAg",
                                  fit: BoxFit.fitWidth,
                                ),
                        ),
                      ),
                      Align(
                        child: Icon(CupertinoIcons.camera_circle,
                            color: Colors.black.withOpacity(0.5), size: 60),
                      )
                    ]),
                  ),
                  onTap: () {
                    Get.dialog(
                      SimpleDialog(
                        contentPadding: EdgeInsets.symmetric(vertical: 5),
                        insetPadding: EdgeInsets.all(0),
                        titlePadding: EdgeInsets.zero,
                        children: [
                          CupertinoButton(
                            padding: EdgeInsets.zero,
                            child: Text("갤러리에서 선택"),
                            onPressed: () => controller
                                .setBackgroundImage(ImageSource.gallery),
                          ),
                          Divider(thickness: 1),
                          CupertinoButton(
                            padding: EdgeInsets.zero,
                            child: Text("사진 촬영"),
                            onPressed: () => controller
                                .setBackgroundImage(ImageSource.camera),
                          )
                        ],
                      ),
                    );
                  }),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.15,
              left: 0,
              right: 0,
              child: Container(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: MediaQuery.of(context).size.height * 0.1,
                  height: MediaQuery.of(context).size.height * 0.1,
                  margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: GestureDetector(
                      child: Stack(
                        children: [
                          Obx(
                            () => Container(
                              color: Colors.amber,
                              height: 200,
                              child: controller.userImage.value != null
                                  ? Image.file(
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      File(controller.userImage.value!.path))
                                  : CachedNetworkImage(
                                      width: double.infinity,
                                      imageUrl:
                                          "https://i.picsum.photos/id/274/300/300.jpg?hmac=ONC6yV48qfvyeyXwAe7QE7b08QXABIQJjwT5chzImAg",
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          Align(
                            child: Icon(CupertinoIcons.camera_circle,
                                color: Colors.black.withOpacity(0.5), size: 40),
                          )
                        ],
                      ),
                      onTap: () {
                        Get.dialog(
                          SimpleDialog(
                            contentPadding: EdgeInsets.symmetric(vertical: 5),
                            insetPadding: EdgeInsets.zero,
                            alignment: Alignment.center,
                            children: [
                              CupertinoButton(
                                padding: EdgeInsets.zero,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("갤러리에서 선택 "),
                                    Icon(CupertinoIcons.photo)
                                  ],
                                ),
                                onPressed: () => controller
                                    .setUserImage(ImageSource.gallery),
                              ),
                              Divider(thickness: 1),
                              CupertinoButton(
                                padding: EdgeInsets.zero,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("사진 촬영 "),
                                    Icon(CupertinoIcons.photo_camera)
                                  ],
                                ),
                                onPressed: () =>
                                    controller.setUserImage(ImageSource.camera),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
