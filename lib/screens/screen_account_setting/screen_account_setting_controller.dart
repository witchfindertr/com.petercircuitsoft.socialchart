import 'package:get/get.dart';
import 'package:socialchart/models/model_user_data.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:get_storage/get_storage.dart';

class ScreenAccountSettingController extends GetxController {
  final UserDataModel? userData;
  ScreenAccountSettingController({this.userData});

  GetStorage setting = GetStorage();
  var _autoTranslateEnable = Rx<bool>(false);

  bool get autoTranslateEnable => _autoTranslateEnable.value;
  set autoTranslateEnable(bool value) => _autoTranslateEnable.value = value;

  late PackageInfo packageInfo;
  @override
  void onInit() async {
    // TODO: implement onInit
    packageInfo = await PackageInfo.fromPlatform();
    setting.writeIfNull("autoTranslate", false);
    autoTranslateEnable = setting.read("autoTranslate");

    ever(
      _autoTranslateEnable,
      (_) => {
        setting.write("autoTranslate", _),
      },
    );
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
