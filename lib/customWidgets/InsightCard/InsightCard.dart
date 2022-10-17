import 'package:flutter/material.dart';

//InsightCard components
import 'InsightCardBody.dart';
import 'InsightCardBottom.dart';
import 'InsightCardHeader.dart';

class InsightCard extends StatelessWidget {
  const InsightCard({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
          margin: const EdgeInsets.all(5),
          semanticContainer: true,
          child: Column(
            children: [
              InsightCardHeader(),
              Divider(
                thickness: 0.5,
                indent: 10,
                endIndent: 10,
              ),
              InsightCardBody(),
              Divider(
                thickness: 0.5,
                indent: 10,
                endIndent: 10,
              ),
              InsightCardBottom()
            ],
          )),
    );
  }
}
