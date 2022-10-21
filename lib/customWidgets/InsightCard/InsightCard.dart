import 'package:flutter/material.dart';

//InsightCard components
import 'InsightCardBody.dart';
import 'InsightCardBottom.dart';
import 'InsightCardHeader.dart';

class InsightCard extends StatelessWidget {
  const InsightCard({super.key});
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
          children: const <Widget>[
            InsightCardHeader(),
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
