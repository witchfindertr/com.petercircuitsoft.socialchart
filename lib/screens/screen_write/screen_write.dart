import 'package:detectable_text_field/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialchart/custom_widgets/gradient_mask.dart';
import 'package:socialchart/custom_widgets/main_appbar.dart';
import 'package:socialchart/navigators/navigator_constant.dart';
// import 'package:socialchart/screens/screen_write/widgets/link_preview.dart';
import 'package:socialchart/screens/screen_write/screen_write_controller.dart';

import 'package:detectable_text_field/detector/sample_regular_expressions.dart';
import 'package:detectable_text_field/widgets/detectable_text_field.dart';
import 'package:any_link_preview/any_link_preview.dart';

class ScreenWrite extends GetView<ScreenWriteController> {
  const ScreenWrite({super.key, this.navKey, required this.chartId});
  static const routeName = "/ScreenWrite";
  final String chartId;
  final NavKeys? navKey;

  @override
  // TODO: implement tag
  String? get tag => navKey?.name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: LinearGradientMask(
          child: Text(
            "${chartId} 차트",
            style: TextStyle(
                fontFamily: "NotoSansKR",
                fontSize: 25,
                fontWeight: FontWeight.w700),
          ),
        ),
        centerTitle: false,
        automaticallyImplyLeading: false,
        actions: [
          Obx(() {
            return CupertinoButton(
              disabledColor: Colors.black12,
              onPressed: controller.userText.isNotEmpty
                  ? () => print("pressed")
                  : null,
              child: LinearGradientMask(
                child: Icon(CupertinoIcons.paperplane, size: 26),
              ),
            );
          }),
        ],
      ),

      //  MainAppBar(
      //   appBar: AppBar(),
      //   title: "${chartId} 차트",
      //   searchButtonVisible: false,
      //   sendButtonVisible: true,
      //   sendButtonOnPressed:
      //       controller.userText.length > 0 ? () => print("hello world") : null,
      // ),
      body: SingleChildScrollView(
        child: Container(
          // color: Colors.black26,
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
            bottom: 50,
          ),
          child: Column(
            children: [
              RawKeyboardListener(
                onKey: (value) {
                  controller.lastKey = value.data.logicalKey.keyLabel;
                },
                focusNode: FocusNode(),
                child: DetectableTextField(
                  keyboardType: TextInputType.multiline,
                  detectionRegExp: controller.userTagRegExp,
                  decoration: InputDecoration(
                    hintText: "자신의 인사이트를 공유해보세요!",
                    border: InputBorder.none,
                  ),
                  autofocus: true,
                  maxLines: null,
                  minLines: null,
                  autocorrect: false,
                  controller: controller.textController,
                  onChanged: (value) {
                    controller.updateUserLink(value);
                  },
                ),
              ),
              Obx(() {
                if (controller.userLink != null) {
                  return Container(
                      child: AnyLinkPreview(
                    displayDirection: UIDirection.uiDirectionHorizontal,
                    link: controller.userLink!,
                    borderRadius: 0,
                    bodyMaxLines: 2,
                    placeholderWidget: Center(child: Text("로딩중")),
                    errorImage: "Error loding image",
                  ));
                } else {
                  return SizedBox();
                }
              }),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10),
          ),
        ),
        child: IconButton(
          splashColor: Colors.transparent,
          onPressed: () => print("pressed"),
          icon: Icon(CupertinoIcons.paperplane),
        ),
      ),
    );
  }
}
