import 'dart:ffi';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:socialchart/custom_widgets/insightcard/insightcard_header.dart';
import 'package:socialchart/models/model_user_insightcard.dart';

class ChartPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  ChartPersistentHeaderDelegate({required this.cardData, required this.height});
  final ModelInsightCard? cardData;
  final double height;
  final spots = List.generate(101, (i) => (i - 50) / 10)
      .map((x) => FlSpot(x, sin(x)))
      .toList();
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    return Card(
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(0)),
        side: BorderSide(
          color: Colors.blueGrey.withOpacity(0.3),
        ),
      ),
      margin: EdgeInsets.zero,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: [
          InsightCardHeader(),
          // AspectRatio(
          //   aspectRatio: 16 / 9,
          //   child: LineChart(
          //     LineChartData(
          //       minY: -1.5,
          //       maxY: 1.5,
          //       lineBarsData: [
          //         LineChartBarData(
          //           color: Colors.black,
          //           spots: spots,
          //           isCurved: true,
          //           isStrokeCapRound: true,
          //           barWidth: 3,
          //           belowBarData: BarAreaData(
          //             show: false,
          //           ),
          //           dotData: FlDotData(show: false),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          Flexible(
              child: Center(
            child: Text(
              cardData?.userText ?? "",
              overflow: TextOverflow.fade,
              softWrap: true,
            ),
          )),
        ],
      ),
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => height;

  @override
  // TODO: implement minExtent
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return true;
  }
}
