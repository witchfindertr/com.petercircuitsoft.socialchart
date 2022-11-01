import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:socialchart/custom_widgets/main_appbar.dart';
import 'package:socialchart/navigators/navigator_constant.dart';
import 'package:socialchart/navigators/navigator_main/navigator_main_controller.dart';
import 'package:socialchart/screens/screen_write/screen_write.dart';

class ScreenChart extends StatelessWidget {
  const ScreenChart({super.key, this.navKey});
  static const routeName = "/ScreenChart";
  final NavKeys? navKey;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MainAppBar(title: "어떤 차트", appBar: AppBar()),
      body: Container(color: Colors.black12),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Get.toNamed(ScreenWrite.routeName, id: NavKeys.home.index);
        },
        child: Icon(Icons.add),
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          minimumSize: MaterialStateProperty.all<Size?>(
            Size(60, 60),
          ),
          foregroundColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed))
              return Theme.of(context).colorScheme.primary.withOpacity(0.5);
            return null; // Use the component's default.
          }),
        ),
      ),
    );
  }
}
