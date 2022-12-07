import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialchart/custom_widgets/user_avata.dart';
import 'package:socialchart/screens/modal_screen_profile_setting/modal_screen_profile_setting_controller.dart';
import 'package:validators/validators.dart';

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
            onPressed: () => controller.saveProfileInfo(),
            padding: EdgeInsets.zero,
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.3,
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
                            child: Stack(children: [
                              Obx(
                                () => Container(
                                  color: Colors.amber,
                                  height: 200,
                                  child: controller.backgroundNewImage != null
                                      ? Image.file(
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                          File(controller
                                              .backgroundNewImage!.path))
                                      : isURL(controller
                                              .userData.backgroundImageUrl)
                                          ? CachedNetworkImage(
                                              width: double.infinity,
                                              imageUrl: controller
                                                  .userData.backgroundImageUrl!,
                                              fit: BoxFit.fitWidth,
                                            )
                                          : Container(
                                              color: Colors.grey,
                                            ),
                                ),
                              ),
                              Align(
                                child: Icon(CupertinoIcons.camera_circle,
                                    color: Colors.black.withOpacity(0.5),
                                    size: 60),
                              )
                            ]),
                          ),
                          onTap: () {
                            Get.dialog(
                              SimpleDialog(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 0),
                                insetPadding: EdgeInsets.zero,
                                alignment: Alignment.center,
                                children: [
                                  dialogMenuItem(
                                    icon: CupertinoIcons.photo,
                                    text: "갤러리에서 선택",
                                    onPress: () =>
                                        controller.setBackgroundImage(
                                            ImageSource.gallery),
                                  ),
                                  Divider(thickness: 1),
                                  dialogMenuItem(
                                    icon: CupertinoIcons.photo_camera,
                                    text: "사진 촬영",
                                    onPress: () => controller
                                        .setBackgroundImage(ImageSource.camera),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.2,
                      left: 0,
                      right: 0,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: MediaQuery.of(context).size.height * 0.1,
                          height: MediaQuery.of(context).size.height * 0.1,
                          margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: GestureDetector(
                            child: Stack(
                              children: [
                                Obx(
                                  () => SizedBox(
                                      width:
                                          MediaQuery.of(context).size.height *
                                              0.1,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.1,
                                      child: controller.userNewImage != null
                                          ? CircularPaddedAvatar(
                                              radius: 48,
                                              // padding: 4,
                                              backgroundImage: FileImage(
                                                  controller.userNewImage!),
                                            )
                                          : userAvatar(
                                              padding: 4,
                                              url: controller
                                                  .userData.profileImageUrl,
                                              unique: controller.userId,
                                              radius: 48)),
                                ),
                                Align(
                                  child: Icon(CupertinoIcons.camera_circle,
                                      color: Colors.black.withOpacity(0.5),
                                      size: 40),
                                )
                              ],
                            ),
                            onTap: () {
                              Get.dialog(
                                SimpleDialog(
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 5),
                                  insetPadding: EdgeInsets.zero,
                                  alignment: Alignment.center,
                                  children: [
                                    dialogMenuItem(
                                      icon: CupertinoIcons.photo,
                                      text: "갤러리에서 선택",
                                      onPress: () => controller
                                          .setUserImage(ImageSource.gallery),
                                    ),
                                    Divider(thickness: 1),
                                    dialogMenuItem(
                                      icon: CupertinoIcons.photo_camera,
                                      text: "사진 촬영",
                                      onPress: () => controller
                                          .setUserImage(ImageSource.camera),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              textAndField(
                text: "별 명",
                controller: controller.displayNameFieldController,
                hintText: "어떤 이름으로 불리고 싶나요?",
                maxLength: 10,
              ),
              textAndField(
                text: "내 소개",
                controller: controller.introductinoFieldController,
                hintText: "자신을 소개해 보세요!",
                maxLines: 3,
              ),
              textAndField(
                text: "소 속",
                controller: controller.belongFieldController,
                hintText: "혹시 소속이 있나요?",
                maxLength: 10,
              ),
              textAndField(
                text: "웹사이트",
                controller: controller.websiteFieldController,
                hintText: "자신과 관련된 웹사이트가 있나요?",
                maxLength: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget textAndField({
  required String text,
  required TextEditingController controller,
  String? hintText,
  int maxLines = 1,
  int? maxLength,
}) {
  return Padding(
    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10),
        TextField(
          maxLines: maxLines,
          maxLength: maxLength ?? 50,
          autocorrect: false,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          controller: controller,
          decoration: InputDecoration(
            alignLabelWithHint: false,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.blueAccent),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget dialogMenuItem({
  required IconData icon,
  required String text,
  VoidCallback? onPress,
}) {
  return CupertinoButton(
    onPressed: onPress,
    padding: EdgeInsets.zero,
    child: Row(
      children: [
        Expanded(
          flex: 1,
          child: Icon(icon),
        ),
        Expanded(
          flex: 2,
          child: Text(text),
        ),
      ],
    ),
  );
}
