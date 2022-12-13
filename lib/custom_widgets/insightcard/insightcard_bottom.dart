import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/custom_widgets/insightcard/insightcard_controller.dart';
import 'package:socialchart/models/model_user_insightcard.dart';

class InsightCardBottom extends StatelessWidget {
  const InsightCardBottom({
    super.key,
    required this.cardId,
    required this.navKey,
    required this.tag,
  });
  final String cardId;
  final String tag;
  final NavKeys? navKey;

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<InsightCardController>(tag: tag);
    final iconSize = MediaQuery.of(context).size.width * 0.05;
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
                    color: controller.likePressed ? Colors.red : Colors.black87,
                  ),
                ),
                Text(
                  controller.currentLikeCounter.toString(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: "Sans",
                    color: Colors.black87,
                  ),
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
                    color:
                        controller.scrapPressed ? Colors.red : Colors.black87,
                  ),
                ),
                Text(
                  controller.currentScrapCounter.toString(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: "Sans",
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                CupertinoButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: () => controller.onCommentButtonPress(navKey!),
                  alignment: Alignment.center,
                  child: Icon(
                    CupertinoIcons.chat_bubble,
                    size: iconSize,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  (controller.cardInfo.commentCounter ?? 0).toString(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: "Sans",
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            CupertinoButton(
              padding: const EdgeInsets.all(0),
              onPressed: controller.onSharePress,
              alignment: Alignment.center,
              child: Icon(
                CupertinoIcons.share,
                size: iconSize,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
