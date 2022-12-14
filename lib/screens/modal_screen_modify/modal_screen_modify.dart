import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialchart/custom_widgets/appbar_buttons.dart';
import 'package:socialchart/custom_widgets/gradient_mask.dart';
import 'package:socialchart/app_constant.dart';

import 'package:socialchart/custom_widgets/main_sliver_appbar.dart';
import 'package:socialchart/screens/modal_screen_modify/modal_screen_modify_controller.dart';

import 'package:detectable_text_field/detector/sample_regular_expressions.dart';
import 'package:detectable_text_field/widgets/detectable_text_field.dart';
import 'package:socialchart/screens/screen_write/widgets/link_preview.dart';

class ModalScreenModify extends GetView<ModalScreenModifyController> {
  const ModalScreenModify({
    super.key,
    this.navKey,
  });

  final NavKeys? navKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppbar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        automaticallyImplyLeading: true,
        leading: LinearGradientMask(
          child: CupertinoButton(
            onPressed: () => Navigator.pop(context),
            child: Icon(
              CupertinoIcons.xmark,
            ),
          ),
        ),
        titleText: "${controller.chartId} 차트",
        actions: [
          Obx(
            () => appbarSendButton(controller.userText.isNotEmpty
                ? () {
                    controller.updateInsightCard().then((value) {
                      Get.back(result: "complete");
                      Get.snackbar("완료", "게시물이 업로드되었습니다.");
                    });
                  }
                : null),
          ),
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
                              padding: const EdgeInsets.all(0),
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
