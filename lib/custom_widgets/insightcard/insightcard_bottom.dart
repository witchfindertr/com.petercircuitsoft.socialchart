import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:socialchart/models/model_user_insightcard.dart';

class InsightCardBottom extends StatelessWidget {
  const InsightCardBottom({
    super.key,
    this.scrapCount = 0,
    this.commentCount = 0,
    required this.scrapButtonPressed,
    required this.commentButtonPressed,
    required this.shareButtonPressed,
  });

  final int? scrapCount;
  final int? commentCount;
  final VoidCallback scrapButtonPressed;
  final VoidCallback commentButtonPressed;
  final VoidCallback shareButtonPressed;

  @override
  Widget build(BuildContext context) {
    final iconSize = MediaQuery.of(context).size.width * 0.05;
    return Container(
        padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
        height: MediaQuery.of(context).size.width * 0.1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CupertinoButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: scrapButtonPressed,
                  alignment: Alignment.center,
                  child: Icon(
                    CupertinoIcons.paperclip,
                    size: iconSize,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  scrapCount.toString(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: "Sans",
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                CupertinoButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: commentButtonPressed,
                  alignment: Alignment.center,
                  child: Icon(
                    CupertinoIcons.chat_bubble,
                    size: iconSize,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  commentCount.toString(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: "Sans",
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            CupertinoButton(
              padding: const EdgeInsets.all(0),
              onPressed: shareButtonPressed,
              alignment: Alignment.center,
              child: Icon(
                CupertinoIcons.share,
                size: iconSize,
                color: Colors.black87,
              ),
            ),
          ],
        ));
  }
}
