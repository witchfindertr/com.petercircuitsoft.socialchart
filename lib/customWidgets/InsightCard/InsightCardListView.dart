import 'package:flutter/material.dart';
import 'package:socialchart/customWidgets/InsightCard/InsightCard.dart';

class InsightCardListView extends StatelessWidget {
  const InsightCardListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return InsightCard();
      },
    );
  }
}
