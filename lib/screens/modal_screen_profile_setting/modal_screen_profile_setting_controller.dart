import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:get/get.dart";
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/models/firebase_collection_ref.dart';
import 'package:socialchart/models/model_user_data.dart';
import 'package:socialchart/navigators/navigator_main/navigator_main_controller.dart';
import 'package:socialchart/screens/screen_profile/screen_profile.dart';
import 'package:socialchart/screens/screen_profile/screen_profile_controller.dart';
import 'package:socialchart/socialchart/socialchart_controller.dart';

enum UserImageType { userimage, background }

class ModalScreenProfileSettingController extends GetxController {
  final String userId;
  final UserDataModel userData;
  ModalScreenProfileSettingController(
      {required this.userId, required this.userData});
  final ImagePicker imagePicker = ImagePicker();

  Reference storageRef =
      firestorage.ref("/userImage/${firebaseAuth.currentUser!.uid}");

  final displayNameFieldController = TextEditingController();
  final introductinoFieldController = TextEditingController();
  final belongFieldController = TextEditingController();
  final websiteFieldController = TextEditingController();

  final _userNewImage = Rxn<File>();
  final _backgroundNewImage = Rxn<File>();

  File? get userNewImage => _userNewImage.value;
  File? get backgroundNewImage => _backgroundNewImage.value;

  void saveProfileInfo() async {
    Get.back();
    String userNewImageUrl = "";
    String backgroundNewImageUrl = "";
    Map<String, Object?> userUpdateData = {
      "displayName": displayNameFieldController.text.isNotEmpty
          ? displayNameFieldController.text
          : null,
      "introductionMessage": introductinoFieldController.text.isNotEmpty
          ? introductinoFieldController.text
          : null,
      "userUrl": websiteFieldController.text.isNotEmpty
          ? websiteFieldController.text
          : null,
      "belong": belongFieldController.text.isNotEmpty
          ? belongFieldController.text
          : null
    };
    SocialChartController.to.showFullScreenLoadingIndicator = true;
    //save userNewImage
    if (userNewImage != null) {
      var userImageRef = storageRef.child("profileImage");
      await userImageRef.putFile(userNewImage!);
      userNewImageUrl = await userImageRef.getDownloadURL();
      userUpdateData["profileImageUrl"] = userNewImageUrl;
    }
    //save backgroundImage
    if (backgroundNewImage != null) {
      var userImageRef = storageRef.child("backgroundImage");
      await userImageRef.putFile(backgroundNewImage!);
      backgroundNewImageUrl = await userImageRef.getDownloadURL();
      userUpdateData["backgroundImageUrl"] = backgroundNewImageUrl;
    }

    await userDataColRef()
        .doc(firebaseAuth.currentUser!.uid)
        .update(userUpdateData)
        .then(
          (value) {},
          onError: (e) => print(e),
        );
    SocialChartController.to.showFullScreenLoadingIndicator = false;
    Get.find<ScreenProfileController>(tag: NavKeys.profile.name).getUserData();
  }

  Future setUserImage(ImageSource imageSource) async {
    try {
      var tempImage = await imagePicker.pickImage(source: imageSource);
      if (tempImage != null) {
        ImageCropper().cropImage(
          cropStyle: CropStyle.circle,
          sourcePath: tempImage.path,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          uiSettings: [
            AndroidUiSettings(
                toolbarTitle: 'Cropper',
                toolbarColor: Colors.deepOrange,
                toolbarWidgetColor: Colors.white,
                initAspectRatio: CropAspectRatioPreset.original,
                lockAspectRatio: false),
            IOSUiSettings(
              title: 'Cropper',
              aspectRatioLockEnabled: true,
              resetAspectRatioEnabled: false,
            ),
          ],
        ).then((croppedImage) {
          if (croppedImage != null) {
            _userNewImage.value = File(croppedImage.path);
          }
          Get.back();
        });
      }
    } catch (e) {
      print(e);
      Get.back();
    }
  }

  Future setBackgroundImage(ImageSource imageSource) async {
    try {
      var tempImage = await imagePicker.pickImage(source: imageSource);
      if (tempImage != null) {
        ImageCropper().cropImage(
          sourcePath: tempImage.path,
          aspectRatio: CropAspectRatio(ratioX: 16, ratioY: 9),
          uiSettings: [
            AndroidUiSettings(
                toolbarTitle: 'Cropper',
                toolbarColor: Colors.deepOrange,
                toolbarWidgetColor: Colors.white,
                initAspectRatio: CropAspectRatioPreset.original,
                lockAspectRatio: false),
            IOSUiSettings(
              title: 'Cropper',
              aspectRatioLockEnabled: true,
              resetAspectRatioEnabled: false,
            ),
          ],
        ).then((croppedImage) {
          if (croppedImage != null) {
            _backgroundNewImage.value = File(croppedImage.path);
          }
          Get.back();
        });
      }
    } catch (e) {
      print(e);
      Get.back();
    }
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    displayNameFieldController.text = userData.displayName ?? "";
    belongFieldController.text = userData.belong ?? "";
    introductinoFieldController.text = userData.introductionMessage ?? "";
    websiteFieldController.text = userData.userUrl ?? "";
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
