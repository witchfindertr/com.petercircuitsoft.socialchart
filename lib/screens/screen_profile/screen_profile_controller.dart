import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/models/firebase_collection_ref.dart';
import 'package:socialchart/models/model_user_data.dart';

class ScreenProfileController extends GetxController {
  ScreenProfileController({required this.userId});
  final String userId;
  // static ScreenProfileController get to => Get.find();

  final _isCurrentUser = false.obs;

  var scrollController = ScrollController();

  bool get isCurrentUser => _isCurrentUser.value;
  set isCurrentUser(bool value) => _isCurrentUser.value = value;

  final Rxn<UserDataModel?> _userData = Rxn<UserDataModel?>();

  UserDataModel? get userData => _userData.value;
  set userData(UserDataModel? value) => _userData.value = value;

  var isloading = true.obs;
  bool get isLoading => isloading.value;
  set isLoading(bool value) => isloading.value = value;

  Future<DocumentSnapshot<UserDataModel>> getUserData(String userId) {
    try {
      return userDataColRef().doc(userId).get();
    } catch (error) {
      rethrow;
    }
  }

  @override
  void onInit() async {
    isLoading = true;
    if (userId == firebaseAuth.currentUser?.uid) _isCurrentUser.value = true;
    var result = await getUserData(userId);
    userData = result.data();
    isLoading = false;

    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    scrollController.dispose();
    super.onClose();
  }
}
