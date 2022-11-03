import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:socialchart/models/model_user_data.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class ScreenProfileController extends GetxController {
  static ScreenProfileController get to => Get.find();
  final userDataColRef = firestore.collection("userData").withConverter(
        fromFirestore: (snapshot, options) {
          // print("Snapshot: ${snapshot.data()}");
          return UserData.fromJson(snapshot.data()!);
        },
        toFirestore: (value, options) => value.toJson(),
      );
  var _userId = "".obs;
  var isloading = true.obs;
  late Rxn<UserData?> userData = Rxn<UserData?>();

  bool get isLoading => isloading.value;
  void set isLoading(bool value) => isloading.value = value;

  String get userId => _userId.value;
  set userId(String? value) =>
      value != null ? _userId.value = value : _userId.value = "";

  void setUserId(String value) {
    _userId.value = value;
  }

  @override
  void onInit() async {
    isLoading = true;
    ever(_userId, (_) async {
      var _userData = await getUserData(_userId.value);
      userData.value = _userData.data();
      isLoading = false;
      print("ever!!: ${userData.value!.createdAt.toDate().toString()}");
    });

    super.onInit();
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
