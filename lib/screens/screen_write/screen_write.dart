import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialchart/custom_widgets/gradient_mask.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/custom_widgets/insightcard/insightcard_list_controller.dart';
import 'package:socialchart/screens/screen_write/screen_write_controller.dart';

import 'package:detectable_text_field/detector/sample_regular_expressions.dart';
import 'package:detectable_text_field/widgets/detectable_text_field.dart';
import 'package:socialchart/screens/screen_write/widgets/link_preview.dart';

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
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: LinearGradientMask(
          child: Text(
            "${controller.chartId} 차트",
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
                  ? () {
                      controller.addInsightCard().then((value) {
                        Get.back(id: navKey?.index, result: "complete");
                        Get.snackbar("완료", "게시물이 업로드되었습니다.");
                      });
                    }
                  : null,
              child: LinearGradientMask(
                child: Icon(CupertinoIcons.paperplane, size: 26),
              ),
            );
          }),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            bottom: 50,
          ),
          child: Column(
            children: [
              DetectableTextField(
                keyboardType: TextInputType.multiline,
                detectionRegExp: hashTagUrlRegExp,
                decoration: const InputDecoration(
                  hintText: "자신의 인사이트를 공유해보세요!",
                  border: InputBorder.none,
                ),
                autofocus: true,
                maxLines: null,
                minLines: null,
                autocorrect: false,
                controller: controller.textController,
                onChanged: (value) {
                  controller.userText = value;
                },
              ),
              Obx(
                () => controller.previewLink != null
                    ? Stack(
                        children: [
                          LinkPreview(
                            imageUrl: controller.linkData?.image,
                            title: controller.linkData?.title,
                            description: controller.linkData?.description,
                            url: controller.previewLink!,
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: CupertinoButton(
                              minSize: 10,
                              padding: EdgeInsets.all(0),
                              onPressed: () {
                                controller.deletedLink =
                                    controller.previewLink!;
                                controller.previewLink = null;
                              },
                              child: Icon(Icons.cancel, color: Colors.black45),
                            ),
                          )
                        ],
                      )
                    : const SizedBox(),
              ),
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
          onPressed: () => print("??pressed"),
          icon: Icon(CupertinoIcons.paperplane),
        ),
      ),
    );
  }
}
