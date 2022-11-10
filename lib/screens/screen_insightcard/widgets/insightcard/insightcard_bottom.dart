import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:socialchart/models/model_user_insightcard.dart';

class InsightCardBottomController extends GetxController {
  static InsightCardBottomController get to => Get.find();

  var _cardInfo = Rxn<InsightCardModel>();

  var _replyCount = 0.obs;
  var _pinCount = 0.obs;

  int get replyCount => _replyCount.value;
  set replyCount(int value) => _replyCount.value = value;

  int get pinCount => _pinCount.value;
  set pinCount(int value) => _pinCount.value = value;

  set cardInfo(InsightCardModel value) => _cardInfo.value = value;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _cardInfo.value = null;

    ever(_cardInfo, (cardInfo) {
      if (cardInfo != null) {
        _replyCount.value = cardInfo.replyCount;
        _pinCount.value = cardInfo.pinCount;
      }
    });
  }
}

class InsightCardBottom extends StatelessWidget {
  const InsightCardBottom({
    super.key,
    required this.cardId,
    required this.cardInfo,
  });
  final String cardId;
  final InsightCardModel cardInfo;

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(InsightCardBottomController(), tag: cardId);
    controller.cardInfo = cardInfo;
    final iconSize = MediaQuery.of(context).size.width * 0.04;
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CupertinoButton(
            padding: EdgeInsets.all(0),
            child: Row(
              children: [
                Icon(
                  CupertinoIcons.collections,
                  size: iconSize,
                  color: Colors.black87,
                ),
                SizedBox(width: 10),
                Text(
                  controller.pinCount.toString(),
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Sans",
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            onPressed: () => {},
            alignment: Alignment.center),
        CupertinoButton(
            padding: EdgeInsets.all(0),
            child: Row(
              children: [
                Icon(
                  CupertinoIcons.chat_bubble,
                  size: iconSize,
                  color: Colors.black87,
                ),
                SizedBox(width: 10),
                Text(
                  controller.replyCount.toString(),
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Sans",
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            onPressed: () => {print("todo: jump to the ScreenInsightCard")},
            alignment: Alignment.center),
        CupertinoButton(
            padding: EdgeInsets.all(0),
            child: Icon(
              CupertinoIcons.share,
              size: iconSize,
              color: Colors.black87,
            ),
            onPressed: () => {
                  Share.share("check out my website https://example.com/11",
                      subject: "Social chart")
                },
            alignment: Alignment.center),
      ],
    ));
  }
}
