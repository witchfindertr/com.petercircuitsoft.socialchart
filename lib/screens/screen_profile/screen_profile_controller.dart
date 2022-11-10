import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/models/model_user_data.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class ScreenProfileController extends GetxController {
  ScreenProfileController({required this.userId});
  final String userId;
  static ScreenProfileController get to => Get.find();
  final userDataColRef = firestore.collection("userData").withConverter(
        fromFirestore: (snapshot, options) {
          // print("Snapshot: ${snapshot.data()}");
          return UserDataModel.fromJson(snapshot.data()!);
        },
        toFirestore: (value, options) => value.toJson(),
      );

  final _isCurrentUser = false.obs;

  bool get isCurrentUser => _isCurrentUser.value;
  set isCurrentUser(bool value) => _isCurrentUser.value = value;

  var isloading = true.obs;
  final Rxn<UserDataModel?> _userData = Rxn<UserDataModel?>();

  UserDataModel? get userData => _userData.value;
  set userData(UserDataModel? value) => _userData.value = value;

  bool get isLoading => isloading.value;
  set isLoading(bool value) => isloading.value = value;

  @override
  void onInit() async {
    isLoading = true;
    if (userId == firebaseAuth.currentUser?.uid) _isCurrentUser.value = true;
    var result = await getUserData(userId);
    userData = result.data();
    isLoading = false;

    super.onInit();
  }

  Future<DocumentSnapshot<UserDataModel>> getUserData(String userId) {
    try {
      return userDataColRef.doc(userId).get();
    } catch (error) {
      rethrow;
    }
  }
}
