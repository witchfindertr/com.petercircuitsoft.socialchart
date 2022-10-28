import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:socialchart/models/userData.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class UserProfileController extends GetxController {
  static UserProfileController get to => Get.find();
  final userDataColRef = firestore.collection("userData").withConverter(
        fromFirestore: (snapshot, options) {
          // print("Snapshot: ${snapshot.data()}");
          return UserData.fromJson(snapshot.data()!);
        },
        toFirestore: (value, options) => value.toJson(),
      );
  var _userId = "".obs;
  var isLoading = true.obs;
  late Rxn<UserData?> userData = Rxn<UserData?>();

  String get userId => _userId.value;
  set userId(String value) => _userId.value = value;

  void setUserId(String value) {
    _userId.value = value;
  }

  @override
  void onInit() async {
    super.onInit();
    once(_userId, (_) async {
      var _userData = await getUserData(_userId.value);
      userData = Rxn<UserData?>(_userData.data());
      print("once!!: ${userData.value!.createdAt.toDate().toString()}");
    });

    // ever(_authUserId, (_) async {
    //   print("ever auth data: ${authUserData.value}");
    //   isLoading.value = true;
    //   var _userData = await getUserData(_userId.value);
    //   userData = Rxn<UserData?>(_userData.data());
    //   isLoading.value = false;
    // });

    // _authUserId.value = FirebaseAuth.instance.currentUser!.uid;
  }

  Future<void> updateUser(String userId) async {
    try {
      userDataColRef.doc(userId).get().then((value) {
        userData = Rxn<UserData?>(value.data());
        _userId.value = userId;
      });
    } catch (error) {
      rethrow;
    }
  }

  Future<DocumentSnapshot<UserData>> getUserData(String userId) {
    try {
      return userDataColRef.doc(userId).get();
    } catch (error) {
      rethrow;
    }
  }
}
