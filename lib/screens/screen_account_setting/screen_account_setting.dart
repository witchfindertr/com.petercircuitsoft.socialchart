import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/controllers/auth_controller.dart';
import 'package:socialchart/screens/screen_account_setting/screen_account_setting_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:socialchart/custom_widgets/main_sliver_appbar.dart';

class ScreenAccountSetting extends GetView<ScreenAccountSettingController> {
  final NavKeys? navKey;
  const ScreenAccountSetting({super.key, this.navKey});

  static const routeName = "/ScreenAccountSetting";

  @override
  // TODO: implement tag
  String? get tag => navKey?.name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MainAppbar(titleText: "설정"),
        body: Column(
          children: [
            ListTile(
              leading: Icon(CupertinoIcons.person),
              title: Text("내 계정 정보"),
              subtitle: Text("내 계정 정보를 확인합니다."),
              onTap: () => showCupertinoModalBottomSheet(
                barrierColor: Colors.transparent.withOpacity(0.5),
                context: context,
                builder: (context) {
                  return FractionallySizedBox(
                    heightFactor: 0.5,
                    child: Column(
                      children: [
                        ListTile(
                          title: Text("이메일 주소"),
                          trailing: Text(controller.userData!.userEmail),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CupertinoButton(
                              child: Text("로그아웃"),
                              onPressed: () => AuthController.to.signOut(),
                            ),
                            CupertinoButton(
                              child: Text("계정삭제"),
                              onPressed: () => {},
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            ListTile(
              leading: Icon(CupertinoIcons.globe),
              title: Text("언어 설정"),
              subtitle: Text("언어를 설정합니다."),
              onTap: () => showCupertinoModalBottomSheet(
                  barrierColor: Colors.transparent.withOpacity(0.5),
                  context: context,
                  builder: (context) {
                    return FractionallySizedBox(
                      heightFactor: 0.5,
                      child: ListTile(
                        title: Text("자동 번역"),
                        trailing: Obx(
                          () => CupertinoSwitch(
                            value: controller.autoTranslateEnable,
                            onChanged: (value) {
                              controller.autoTranslateEnable =
                                  !controller.autoTranslateEnable;
                            },
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            ListTile(
              leading: Icon(CupertinoIcons.ellipsis),
              title: Text("기타"),
              subtitle: Text("버전, 법적 고지 등 기타 사항을 확인합니다."),
              onTap: () => showCupertinoModalBottomSheet(
                barrierColor: Colors.transparent.withOpacity(0.5),
                context: context,
                builder: (context) {
                  return FractionallySizedBox(
                    heightFactor: 0.5,
                    child: Column(
                      children: [
                        ListTile(
                          title: Text("버전 정보"),
                          trailing: Text(controller.packageInfo.version),
                          onTap: () => {},
                        ),
                        ListTile(
                          title: Text("서비스 이용 약관"),
                          onTap: () {
                            Navigator.pop(context);
                            launchUrl(
                                Uri.parse("https://petercircuitsoft.com"));
                          },
                          trailing: Icon(CupertinoIcons.arrow_right),
                        ),
                        ListTile(
                          title: Text("개인정보 처리방침"),
                          onTap: () {
                            Navigator.pop(context);
                            launchUrl(
                                Uri.parse("https://petercircuitsoft.com"));
                          },
                          trailing: Icon(CupertinoIcons.arrow_right),
                        ),
                        ListTile(
                          title: Text("법적 고지 사항"),
                          onTap: () {
                            Navigator.pop(context);
                            launchUrl(
                                Uri.parse("https://petercircuitsoft.com"));
                          },
                          trailing: Icon(CupertinoIcons.arrow_right),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ));
    throw UnimplementedError();
  }
}
