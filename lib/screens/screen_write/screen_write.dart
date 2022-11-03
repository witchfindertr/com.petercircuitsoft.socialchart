import 'package:detectable_text_field/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialchart/custom_widgets/main_appbar.dart';
import 'package:socialchart/navigators/navigator_constant.dart';
import 'package:socialchart/screens/screen_write/screen_write_controller.dart';

import 'package:detectable_text_field/detector/sample_regular_expressions.dart';
import 'package:detectable_text_field/widgets/detectable_text_field.dart';
import 'package:any_link_preview/any_link_preview.dart';

class ScreenWrite extends GetView<ScreenWriteController> {
  const ScreenWrite({super.key, this.navKey});
  static const routeName = "/ScreenWrite";
  final NavKeys? navKey;
  @override
  // TODO: implement tag
  String? get tag => navKey?.name;

  @override
  Widget build(BuildContext context) {
    var userTagRegExp = RegExp(
      "(?!\\n)(?:^|\\s)([#@]([$detectionContentLetters]+))|$urlRegexContent",
      multiLine: true,
    );
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: MainAppBar(
          appBar: AppBar(
            centerTitle: false,
          ),
          title: "뭐머 차트"),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black26,
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
            bottom: 50,
          ),
          child: Column(children: [
            DetectableTextField(
              detectionRegExp: userTagRegExp,
              decoration: InputDecoration(
                  hintText: "자신의 인사이트를 공유해보세요!", border: InputBorder.none),
              autofocus: true,
              maxLines: null,
              minLines: null,
              autocorrect: false,
              controller: controller.textController,
              onChanged: (value) {
                if (value.substring(value.length - 1) == ' ' ||
                    value.substring(value.length - 1) == '\n') {
                  controller.userLink =
                      extractDetections(value, userTagRegExp).isEmpty
                          ? null
                          : extractDetections(value, userTagRegExp)[0];
                }
                print(controller.userLink);
              },
            ),
            Obx(() {
              if (controller.linkData.value != null) {
                return Container(
                    width: double.infinity,
                    color: Colors.white,
                    child: Column(
                      children: [
                        Container(
                          child: Image.network(
                            controller.linkData.value!.image!,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(controller.linkData.value!.title!),
                        Text(controller.linkData.value!.desc!),
                      ],
                    ));
              } else {
                return SizedBox();
              }
            }),
          ]
              //   HashTagTextField(
              //     controller: controller.textController,
              //     decoration: InputDecoration(
              //         hintText: "자신의 인사이트를 공유해보세요!", border: InputBorder.none),
              //     onChanged: (userText) {
              //       RegExp hashTag = RegExp('#[a-z0-9_]+'); //hash tag
              //       RegExp chartTag = RegExp('@[a-z0-9_]+'); //hash tag
              //       controller.userText = userText;
              //       hashTag.allMatches(userText).forEach((element) {
              //         print(element[0]);
              //       });
              //     },
              //     autofocus: true,
              //     maxLines: null,
              //     minLines: null,
              //   ),
              // ],
              ),
          // TextField(
          //   textAlign: TextAlign.start,
          //   textAlignVertical: TextAlignVertical.top,
          //   decoration:
          //       InputDecoration(hintText: "asdf", border: InputBorder.none),
          //   expands: true,
          //   autofocus: true,
          //   maxLines: null,
          //   minLines: null,
          // ),
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
