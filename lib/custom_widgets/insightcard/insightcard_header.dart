import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:socialchart/custom_widgets/asset_and_price.dart';
import 'package:socialchart/custom_widgets/insightcard/insightcard_header_controller.dart';

class InsightCardHeader extends StatelessWidget {
  const InsightCardHeader({super.key, required this.chartId});

  final String chartId;

  @override
  Widget build(BuildContext context) {
    var controller =
        Get.put(InsightCardHeaderController(chartId: chartId), tag: chartId);
    return SizedBox(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text(
                  controller.chartInfo?.chartName ?? "Loading...",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              Container(
                //current description
                child: Text(
                  "39%, +1%",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              Container(
                //last event date
                child: Text(
                  "2022.12.12",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
            child: Marquee(
              style: Theme.of(context).textTheme.bodySmall,
              text:
                  "NBS 조사는 휴대전화 가상번호(100%)를 이용한 전화 면접으로 이뤄졌고, 표본 오차는 95% 신뢰수준에서 ±3.1% 포인트다. 응답률은 20.2%",
              blankSpace: 100.0,
              startAfter: 1.seconds,
              crossAxisAlignment: CrossAxisAlignment.start,
              pauseAfterRound: 1.seconds,
            ),
          ),
        ],
      ),
    );
  }
}

Widget arrayToRichText(List<String> arry, TextStyle style) {
  return Text.rich(
    TextSpan(
      children: arry
          .map(
            (e) => TextSpan(
              text: e,
              style: style,
            ),
          )
          .toList(),
    ),
  );
}
