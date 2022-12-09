import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:socialchart/custom_widgets/insightcard/insightcard_header.dart';

class ChartPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  ChartPersistentHeaderDelegate({required this.time});
  final Timestamp time;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: GestureDetector(
        onHorizontalDragUpdate: (details) => print(details),
        onVerticalDragUpdate: (details) => print(details),
        child: Card(
          margin: EdgeInsets.zero,
          child: Column(
            children: [
              InsightCardHeader(),
              Text("chart"),
              Text(time.toDate().toString()),
            ],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => 221;

  @override
  // TODO: implement minExtent
  double get minExtent => 221;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return true;
  }
}
