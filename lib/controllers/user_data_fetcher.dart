import 'package:get/get.dart';
import 'package:socialchart/models/firebase_collection_ref.dart';
import 'package:socialchart/models/model_user_data.dart';

class UserDataFetcher extends GetxController {
  UserDataFetcher({required this.userId});

  final String userId;
  final _userData = Rxn<ModelUserData>();
  ModelUserData? get userData => _userData.value;

  @override
  void refresh() {
    userDataColRef().doc(userId).get().then((value) {
      _userData.value = value.data();
    });
    super.refresh();
  }

  @override
  void onInit() {
    userDataColRef().doc(userId).get().then((value) {
      _userData.value = value.data();
    });
    super.onInit();
  }
}
