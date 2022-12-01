import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:get/get.dart";
import 'package:image_picker/image_picker.dart';

enum UserImageType { userimage, background }

class ModalScreenProfileSettingController extends GetxController {
  final ImagePicker imagePicker = ImagePicker();
  // XFile? userImage;
  // XFile? backgroundImage;

  var userImage = Rxn<XFile>();
  var backgroundImage = Rxn<XFile>();
  Future setUserImage(ImageSource imageSource) async {
    try {
      userImage.value = await imagePicker.pickImage(source: imageSource);
    } catch (e) {
      print(e);
      Get.back();
    }
  }

  Future setBackgroundImage(ImageSource imageSource) async {
    try {
      backgroundImage.value = await imagePicker.pickImage(
          source: imageSource, preferredCameraDevice: CameraDevice.rear);
      inspect(backgroundImage);
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
