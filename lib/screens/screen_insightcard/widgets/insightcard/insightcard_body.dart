import 'package:any_link_preview/any_link_preview.dart';
import 'package:detectable_text_field/detectable_text_field.dart';
import 'package:detectable_text_field/detector/sample_regular_expressions.dart';
import 'package:flutter/material.dart';
import 'package:socialchart/models/model_user_insightcard.dart';
import 'package:socialchart/screens/screen_write/widgets/link_preview.dart';
import 'package:url_launcher/url_launcher.dart';
import './insightcard_author.dart';

import 'dart:developer';

class InsightCardBody extends StatelessWidget {
  const InsightCardBody({super.key, required this.cardInfo});
  final InsightCardModel cardInfo;

  @override
  Widget build(BuildContext context) {
    // inspect(cardInfo);
    return Container(
      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InsightCardAuthor(author: "Peter Bang", elapsed: "10w ago"),
          DetectableText(
            maxLines: 10,
            text: cardInfo.userText,
            detectionRegExp: hashTagUrlRegExp,
          ),
          cardInfo.linkPreviewData != null
              ? Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12),
                  ),
                  child: LinkPreview(
                    imageUrl: cardInfo.linkPreviewData!.image!,
                    title: cardInfo.linkPreviewData!.title!,
                    description: cardInfo.linkPreviewData?.description,
                    tapCallback: () =>
                        launchUrl(Uri.parse(cardInfo.linkPreviewData!.url!)),
                  ))
              : const SizedBox(),
        ],
      ),
    );
  }
}
