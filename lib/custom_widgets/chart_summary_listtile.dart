import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CharSummaryListTile extends StatelessWidget {
  const CharSummaryListTile({
    super.key,
    required this.title,
    this.description,
    this.userCount,
    this.cardCount,
    this.tapCallback,
  });
  final String title;
  final String? description;
  final int? userCount;
  final int? cardCount;
  final VoidCallback? tapCallback;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      isThreeLine: description != null ? true : false,
      title: Text(title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            description ?? "설명이 없습니다.",
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          Text(
            "관심 사용자: ${userCount ?? 0}, 인사이트 카드 수: ${cardCount ?? 0}",
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
      onTap: tapCallback,
    );
  }
}

Widget chartSummaryListTile({
  required String title,
  String? description,
  int? userCount,
  int? cardCount,
  VoidCallback? tapCallback,
}) {
  return ListTile(
    contentPadding: EdgeInsets.zero,
    isThreeLine: description != null ? true : false,
    title: Text(title),
    subtitle: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        description != null
            ? Text(
                description,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              )
            : SizedBox(),
        Text(
          "관심 사용자: ${userCount ?? 0}, 인사이트 카드 수: ${cardCount ?? 0}",
        ),
      ],
    ),
    onTap: tapCallback,
  );
}
