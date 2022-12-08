import 'package:detectable_text_field/detectable_text_field.dart';
import 'package:detectable_text_field/detector/sample_regular_expressions.dart';
import 'package:flutter/material.dart';
import 'package:socialchart/models/model_user_data.dart';
import 'package:socialchart/models/model_user_insightcard.dart';
import 'package:socialchart/screens/screen_write/widgets/link_preview.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import './insightcard_author.dart';

import 'dart:developer';

class InsightCardBody extends StatelessWidget {
  const InsightCardBody({super.key, required this.cardInfo, this.trimLine});
  final ModelInsightCard cardInfo;
  final int? trimLine;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DetectableText(
            text: cardInfo.userText.trim(),
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
          cardInfo.linkPreviewData != null
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
                    imageUrl: cardInfo.linkPreviewData!.image!,
                    title: cardInfo.linkPreviewData!.title!,
                    description: cardInfo.linkPreviewData?.description,
                    tapCallback: () =>
                        launchUrl(Uri.parse(cardInfo.linkPreviewData!.url!)),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
