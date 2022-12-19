import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/controllers/insightcard_data_fetcher.dart';
import 'package:socialchart/custom_widgets/insightcard/insightcard_bottom_controller.dart';
import 'package:socialchart/custom_widgets/insightcard/insightcard_controller.dart';
import 'package:socialchart/models/model_user_insightcard.dart';
import 'package:socialchart/screens/screen_insightcard/screen_insightcard.dart';

class InsightCardBottom extends StatelessWidget {
  const InsightCardBottom({
    super.key,
    required this.cardId,
    required this.cardData,
    required this.navKey,
  });
  final String cardId;
  final ModelInsightCard cardData;
  final NavKeys? navKey;

  @override
  Widget build(BuildContext context) {
    final iconSize = MediaQuery.of(context).size.width * 0.05;
    return GetBuilder(
      init: InsightCardBottomController(cardId: cardId, cardData: cardData),
      tag: cardId,
      builder: (controller) {
        return Container(
          padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
          height: MediaQuery.of(context).size.width * 0.1,
          child: Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CupertinoButton(
                      padding: const EdgeInsets.all(0),
                      onPressed: controller.onLikeButtonPress,
                      alignment: Alignment.center,
                      child: Icon(
                        controller.likePressed
                            ? CupertinoIcons.hand_thumbsup_fill
                            : CupertinoIcons.hand_thumbsup,
                        size: iconSize,
                        color: controller.likePressed
                            ? Colors.red
                            : Theme.of(context).iconTheme.color,
                      ),
                    ),
                    Text(
                      controller.currentLikeCounter.toString(),
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ],
                ),
                Row(
                  children: [
                    CupertinoButton(
                      padding: const EdgeInsets.all(0),
                      onPressed: controller.onScrapButtonPress,
                      alignment: Alignment.center,
                      child: Icon(
                        CupertinoIcons.paperclip,
                        size: iconSize,
                        color: controller.scrapPressed
                            ? Colors.red
                            : Theme.of(context).iconTheme.color,
                      ),
                    ),
                    Text(controller.currentScrapCounter.toString(),
                        style: Theme.of(context).textTheme.bodyText2),
                  ],
                ),
                Row(
                  children: [
                    CupertinoButton(
                      padding: const EdgeInsets.all(0),
                      onPressed: () {
                        if (ModalRoute.of(context)!.settings.name !=
                            ScreenInsightCard.routeName) {
                          controller.onCommentButtonPress(navKey!);
                        }
                      },
                      alignment: Alignment.center,
                      child: Icon(CupertinoIcons.chat_bubble,
                          size: iconSize,
                          color: Theme.of(context).iconTheme.color),
                    ),
                    Text((controller.currentCommentCounter ?? 0).toString(),
                        style: Theme.of(context).textTheme.bodyText2),
                  ],
                ),
                CupertinoButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: () => controller.onSharePress(),
                  alignment: Alignment.center,
                  child: Icon(CupertinoIcons.share,
                      size: iconSize, color: Theme.of(context).iconTheme.color),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
