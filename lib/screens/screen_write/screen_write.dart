import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialchart/custom_widgets/main_appbar.dart';
import 'package:socialchart/navigators/navigator_constant.dart';
import 'package:socialchart/navigators/navigator_main/navigator_main_controller.dart';
import 'package:socialchart/screens/screen_write/screen_write_controller.dart';

class ScreenWrite extends GetView<ScreenWriteController> {
  const ScreenWrite({super.key, this.navKey});
  static const routeName = "/ScreenWrite";
  final NavKeys? navKey;
  @override
  // TODO: implement tag
  String? get tag => navKey?.name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: MainAppBar(
          appBar: AppBar(
            centerTitle: false,
          ),
          title: "뭐머 차트"),
      body: Container(
        color: Colors.black26,
        padding: EdgeInsets.only(
          left: 10,
          right: 10,
          bottom: 50,
        ),
        child: TextField(
          textAlign: TextAlign.start,
          textAlignVertical: TextAlignVertical.top,
          decoration:
              InputDecoration(hintText: "asdf", border: InputBorder.none),
          expands: true,
          autofocus: true,
          maxLines: null,
          minLines: null,
        ),
      ),
      bottomSheet: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
        child: IconButton(
            splashColor: Colors.transparent,
            onPressed: () => print("pressed"),
            icon: Icon(CupertinoIcons.paperplane)),
        //== 50 to big
      ),
    );

    // return Container(
    //   child: Text("alsdfjkakldfja"),
    //   decoration: BoxDecoration(
    //       borderRadius: BorderRadius.all(
    //         Radius.circular(20),
    //       ),
    //       color: Colors.amber),
    // );
  }
}
