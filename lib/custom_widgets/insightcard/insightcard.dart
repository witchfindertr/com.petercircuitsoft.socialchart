import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/custom_widgets/insightcard/insightcard_controller.dart';
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

class InsightCard extends GetView<InsightCardController> {
  const InsightCard({
    super.key,
    this.navKey,
    this.showHeader = true,
    required this.cardId,
    required this.cardInfo,
    this.trimLine,
  });
  final bool showHeader;
  final NavKeys? navKey;
  final String cardId;
  final ModelInsightCard cardInfo;
  final int? trimLine;

  @override
  // TODO: implement tag
  String? get tag => cardId;

  @override
  Widget build(BuildContext context) {
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
              showHeader
                  ? GestureDetector(
                      child: InsightCardHeader(),
                      behavior: HitTestBehavior.opaque,
                      onTap: () => Get.toNamed(ScreenChart.routeName,
                          id: navKey?.index, arguments: cardInfo.chartId),
                    )
                  : SizedBox(),
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
                cardId: cardId,
                navKey: navKey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
