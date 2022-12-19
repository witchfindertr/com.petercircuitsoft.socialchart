import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/controllers/insightcard_data_fetcher.dart';
import 'package:socialchart/controllers/user_data_fetcher.dart';
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

class InsightCard extends StatelessWidget {
  //GetView<InsightCardController> {
  const InsightCard({
    super.key,
    this.showHeader = true,
    this.trimLine,
    required this.navKey,
    required this.routeName,
    required this.cardId,
    required this.cardData,
  });

  final bool showHeader;
  final NavKeys navKey;
  final String routeName;
  final String cardId;
  final ModelInsightCard cardData;
  final int? trimLine;

  @override
  // TODO: implement tag
  // String? get tag => cardId + routeName;

  @override
  Widget build(BuildContext context) {
    var user = Get.put(UserDataFetcher(userId: cardData.author.id),
        tag: cardData.author.id);
    return Card(
      shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0)),
          side: BorderSide(color: Colors.blueGrey.withOpacity(0.3))),
      margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      semanticContainer: true,
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Column(
          children: <Widget>[
            showHeader
                ? GestureDetector(
                    child: InsightCardHeader(),
                    behavior: HitTestBehavior.opaque,
                    onTap: () => Get.toNamed(
                      preventDuplicates: true,
                      ScreenChart.routeName,
                      id: navKey.index,
                      arguments: cardData.chartId,
                    ),
                  )
                : const SizedBox(),
            const Divider(
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
                    id: navKey.index,
                    arguments: cardId,
                  );
                }
              },
              child: InsightCardAuthor(
                tag: cardId + routeName,
                navKey: navKey,
                cardId: cardId,
                cardData: cardData,
              ),
            ),
            InsightCardBody(
              cardId: cardId,
              cardData: cardData,
              trimLine: trimLine,
            ),
            const Divider(
              height: 0,
              indent: 10,
              endIndent: 10,
            ),
            InsightCardBottom(
              cardId: cardId,
              cardData: cardData,
              navKey: navKey,
            ),
          ],
        ),
      ),
    );
  }
}
