import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:get/get.dart";
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:socialchart/models/model_user_data.dart';

enum UserImageType { userimage, background }

class ModalScreenProfileSettingController extends GetxController {
  final String userId;
  final UserDataModel userData;
  ModalScreenProfileSettingController(
      {required this.userId, required this.userData});
  final ImagePicker imagePicker = ImagePicker();

  var _userNewImage = Rxn<File>();
  var _backgroundNewImage = Rxn<File>();

  File? get userNewImage => _userNewImage.value;
  File? get backgroundNewImage => _backgroundNewImage.value;

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
          if (croppedImage != null)
            _userNewImage.value = File(croppedImage.path);
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
          if (croppedImage != null)
            _backgroundNewImage.value = File(croppedImage.path);
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
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
