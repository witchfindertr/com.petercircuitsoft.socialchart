import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class InsightCardBottom extends StatelessWidget {
  const InsightCardBottom({super.key});

  @override
  Widget build(BuildContext context) {
    final iconSize = MediaQuery.of(context).size.width * 0.04;
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CupertinoButton(
            padding: EdgeInsets.all(0),
            child: Row(
              children: [
                Icon(
                  CupertinoIcons.collections,
                  size: iconSize,
                  color: Colors.black87,
                ),
                SizedBox(width: 10),
                Text(
                  "1",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Sans",
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            onPressed: () => {},
            alignment: Alignment.center),
        CupertinoButton(
            padding: EdgeInsets.all(0),
            child: Row(
              children: [
                Icon(
                  CupertinoIcons.chat_bubble,
                  size: iconSize,
                  color: Colors.black87,
                ),
                SizedBox(width: 10),
                Text(
                  "1",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Sans",
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            onPressed: () => {},
            alignment: Alignment.center),
        CupertinoButton(
            padding: EdgeInsets.all(0),
            child: Icon(
              CupertinoIcons.share,
              size: iconSize,
              color: Colors.black87,
            ),
            onPressed: () => {},
            alignment: Alignment.center),
      ],
    ));
  }
}
