import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialchart/models/model_user_data.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class ScreenProfileController extends GetxController {
  ScreenProfileController({required this.userId});
  final String userId;
  static ScreenProfileController get to => Get.find();
  var scrollController = ScrollController();
  final userDataColRef = firestore.collection("userData").withConverter(
        fromFirestore: (snapshot, options) {
          // print("Snapshot: ${snapshot.data()}");
          return UserDataModel.fromJson(snapshot.data()!);
        },
        toFirestore: (value, options) => value.toJson(),
      );

  // var _userId = "".obs;
  var isloading = true.obs;
  late Rxn<UserDataModel?> userData = Rxn<UserDataModel?>();

  bool get isLoading => isloading.value;
  void set isLoading(bool value) => isloading.value = value;

  // String get userId => _userId.value;
  // set userId(String? value) =>
  //     value != null ? _userId.value = value : _userId.value = "";

  // void setUserId(String value) {
  //   _userId.value = value;
  // }

  @override
  void onInit() async {
    isLoading = true;
    var _userData = await getUserData(userId!);
    userData.value = _userData.data();
    isLoading = false;

    // ever(_userId, (_) async {
    //   var _userData = await getUserData(_userId.value);
    //   userData.value = _userData.data();
    //   isLoading = false;
    //   print("ever!!: ${userData.value!.createdAt.toDate().toString()}");
    // });

    super.onInit();
  }

  // Future<void> updateUser(String userId) async {
  //   try {
  //     userDataColRef.doc(userId).get().then((value) {
  //       userData = Rxn<UserDataModel?>(value.data());
  //       _userId.value = userId;
  //     });
  //   } catch (error) {
  //     rethrow;
  //   }
  // }

  Future<DocumentSnapshot<UserDataModel>> getUserData(String userId) {
    try {
      return userDataColRef.doc(userId).get();
    } catch (error) {
      rethrow;
    }
  }
}
