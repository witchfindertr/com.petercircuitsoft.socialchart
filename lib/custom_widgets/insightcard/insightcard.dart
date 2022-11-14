import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/models/firebase_collection_ref.dart';
import 'package:socialchart/models/model_user_data.dart';
import 'package:socialchart/models/model_user_insightcard.dart';
import 'package:socialchart/custom_widgets/insightcard/insightcard_author.dart';
import 'package:socialchart/screens/screen_chart/screen_chart.dart';
import 'package:socialchart/screens/screen_insightcard/screen_insightcard.dart';
import './insightcard_body.dart';
import './insightcard_bottom.dart';
import './insightcard_header.dart';
import 'package:timeago/timeago.dart' as timeago;

class InsightCardController extends GetxController {
  InsightCardController({required this.userId});
  final String userId;

  var userData = Rxn<UserDataModel>();

  void onCommentButtonPress(String cardId, NavKeys? navKey) {
    //move to the Screen InsightCard with some argument or parameter

    Get.toNamed(ScreenInsightCard.routeName,
        arguments: cardId, id: navKey?.index);
  }

  void onSharePress(String cardId) {
    Share.share("Social chart", subject: "${cardId}");
  }

  void onScrapButtonPress() {
    //server update
    //increase the number of Scrap count
    print("Scrap button pressed");
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    userDataColRef()
        .doc(userId)
        .get()
        .then((value) => userData.value = value.data());
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    print("disposed");
  }
}

class InsightCard extends StatelessWidget {
  const InsightCard({
    super.key,
    this.navKey,
    required this.cardId,
    required this.cardInfo,
    this.trimLine,
  });

  final NavKeys? navKey;
  final String cardId;
  final InsightCardModel cardInfo;
  final int? trimLine;

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(
      InsightCardController(userId: cardInfo.author.id),
      tag: cardId,
    );
    return Card(
      shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0)),
          side: BorderSide(color: Colors.blueGrey.withOpacity(0.3))),
      margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      semanticContainer: true,
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Obx(
          () => Column(
            children: <Widget>[
              GestureDetector(
                child: InsightCardHeader(),
                behavior: HitTestBehavior.opaque,
                onTap: () =>
                    Get.toNamed(ScreenChart.routeName, id: navKey?.index),
              ),
              Divider(
                height: 0,
                indent: 10,
                endIndent: 10,
              ),
              GestureDetector(
                onTap: () {
                  if (ModalRoute.of(context)!.settings.name !=
                      ScreenInsightCard.routeName) {
                    Get.toNamed(
                      ScreenInsightCard.routeName,
                      id: navKey?.index,
                      arguments: cardId,
                    );
                  }
                },
                child: InsightCardAuthor(
                  navKey: navKey,
                  cardId: cardId,
                  userId: cardInfo.author.id,
                  userData: controller.userData.value,
                  elapsed:
                      timeago.format(cardInfo.createdAt.toDate(), locale: "kr"),
                ),
              ),
              InsightCardBody(
                cardInfo: cardInfo,
                trimLine: trimLine,
              ),
              Divider(
                height: 0,
                indent: 10,
                endIndent: 10,
              ),
              InsightCardBottom(
                commentCount: cardInfo.commentCount ?? 0,
                scrapCount: cardInfo.pinCount ?? 0,
                commentButtonPressed: () {
                  if (ModalRoute.of(context)!.settings.name ==
                      ScreenInsightCard.routeName) {
                    return;
                  }
                  controller.onCommentButtonPress(cardId, navKey);
                },
                scrapButtonPressed: () => controller.onScrapButtonPress(),
                shareButtonPressed: () => controller.onSharePress(cardId),
              )
            ],
          ),
        ),
      ),
    );
  }
}
