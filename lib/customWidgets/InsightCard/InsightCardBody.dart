import 'package:flutter/material.dart';
import 'package:socialchart/customWidgets/InsightCard/InsightCardAuthor.dart';

class InsightCardBody extends StatelessWidget {
  const InsightCardBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
        child: Column(children: [
          InsightCardAuthor(author: "Peter Bang", elapsed: "10w ago"),
          Text("Card Body"),
          Text(
              "trutStyle, TextAlign? textAlign, TextDirection? textDirection, Locale? locale, bool? softWrap, TextOverflow? overflow, double? textScaleFactor, int? maxLines, String? semanticsLabel, TextWidthBasis? textWidthBasis, TextHeightBehavior? textHeightBehavior, Color? selectionColor})")
        ]));
  }
}
