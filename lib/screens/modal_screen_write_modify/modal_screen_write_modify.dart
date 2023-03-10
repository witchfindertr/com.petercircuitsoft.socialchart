import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialchart/custom_widgets/appbar_buttons.dart';
import 'package:socialchart/custom_widgets/gradient_mask.dart';
import 'package:socialchart/app_constant.dart';

import 'package:socialchart/custom_widgets/main_sliver_appbar.dart';
import 'package:socialchart/screens/modal_screen_write_modify/modal_screen_write_modify_controller.dart';

import 'package:detectable_text_field/detector/sample_regular_expressions.dart';
import 'package:detectable_text_field/widgets/detectable_text_field.dart';
import 'package:socialchart/screens/modal_screen_write_modify/widgets/link_preview.dart';

class ModalScreenWriteModify extends GetView<ModalScreenWriteModifyController> {
  const ModalScreenWriteModify({
    super.key,
    this.navKey,
  });

  final NavKeys? navKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        automaticallyImplyLeading: true,
        centerTitle: true,
        iconTheme:
            IconThemeData(color: Theme.of(context).textTheme.bodyMedium!.color),
        title: Text(
          "${controller.chartId} 차트",
          style: Theme.of(context).textTheme.headline6,
        ),
        actions: [
          Obx(
            () => appbarSendButton(controller.userText.isNotEmpty
                ? () {
                    if (controller.cardId != null) {
                      //new card
                      controller.updateInsightCard().then((value) {
                        Get.back(result: "complete");
                        Get.snackbar("완료", "게시물이 수정되었습니다.");
                      });
                    } else {
                      controller.addInsightCard().then((value) {
                        Get.back(result: "complete");
                        Get.snackbar("완료", "게시물이 업로드되었습니다.");
                      });
                    }
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
                basicStyle: Theme.of(context).textTheme.bodyMedium,
                keyboardType: TextInputType.multiline,
                detectionRegExp: hashTagUrlRegExp,
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
                  controller.userText = value;
                },
              ),
              Obx(
                () => controller.linkPreviewData?.url != null
                    ? Stack(
                        children: [
                          LinkPreview(
                            linkPreviewData: controller.linkPreviewData,
                            setImageSize: controller.setImageSize,
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: CupertinoButton(
                              minSize: 10,
                              padding: const EdgeInsets.all(0),
                              onPressed: () {
                                controller.deletedLink(
                                    controller.linkPreviewData!.url);
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
