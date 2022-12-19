import 'package:detectable_text_field/detectable_text_field.dart';
import 'package:detectable_text_field/detector/sample_regular_expressions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialchart/custom_widgets/insightcard/insightcard_body_controller.dart';
import 'package:socialchart/models/model_user_insightcard.dart';
import 'package:socialchart/screens/modal_screen_write_modify/widgets/link_preview.dart';
import 'package:socialchart/screens/screen_write/widgets/_link_preview.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class InsightCardBody extends StatelessWidget {
  const InsightCardBody({
    super.key,
    required this.cardId,
    required this.cardData,
    this.trimLine,
  });
  final String cardId;
  final ModelInsightCard cardData;
  final int? trimLine;

  @override
  Widget build(BuildContext context) {
    // var controller =
    //     Get.put(InsightCardBodyController(cardId: cardId, cardData: cardData),tag:cardId);
    return GetBuilder(
      init: InsightCardBodyController(cardId: cardId, cardData: cardData),
      tag: cardId,
      builder: (controller) {
        return Container(
          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DetectableText(
                text: controller.userText!.trim(),
                detectionRegExp: hashTagUrlRegExp,
                onTap: ((p0) {
                  if (Uri.parse(p0).isAbsolute) {
                    launchUrlString(p0);
                    return;
                  }
                  if (p0.startsWith("#")) {
                    print("todo:search dialog");
                  }
                }),
                softWrap: true,
                trimExpandedText: "\n\n덜보기",
                trimMode: TrimMode.Line,
                trimLines: trimLine ?? 8,
                trimCollapsedText: "더보기",
                moreStyle: TextStyle(color: Colors.blue, fontSize: 13),
                lessStyle: TextStyle(color: Colors.blue),
              ),
              controller.linkPreview != null
                  ? Container(
                      margin: EdgeInsets.only(top: 10),
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        // border: Border.all(color: Colors.black12),
                        border: Border(
                            top: BorderSide(color: Colors.black12),
                            bottom: BorderSide(color: Colors.black12)),
                      ),
                      child: LinkPreview(
                        linkPreviewData: controller.cardData.linkPreviewData,
                        tapCallback: () =>
                            launchUrl(Uri.parse(controller.linkPreview!.url)),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        );
      },
    );
  }
}
