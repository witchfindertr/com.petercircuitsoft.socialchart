import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialchart/navigators/navigator_constant.dart';
import './insightcard_body.dart';
import './insightcard_bottom.dart';
import './insightcard_header.dart';

//InsightCard components

class InsightCard extends StatelessWidget {
  const InsightCard({super.key, this.navKey});
  final NavKeys? navKey;
  // final cardData;
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
        child: Column(
          children: <Widget>[
            GestureDetector(
                child: Container(child: InsightCardHeader()),
                behavior: HitTestBehavior.opaque,
                onTap: () => Get.toNamed("/ScreenChart", id: navKey?.index)),
            Divider(
              height: 0,
              indent: 10,
              endIndent: 10,
            ),
            InsightCardBody(),
            Divider(
              height: 0,
              indent: 10,
              endIndent: 10,
            ),
            InsightCardBottom()
          ],
        ),
      ),
    );
  }
}
