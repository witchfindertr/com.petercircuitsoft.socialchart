import 'package:flutter/material.dart';

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
        description != null ? Text(description) : SizedBox(),
        Text(
          "관심 사용자: ${userCount ?? 0}, 인사이트 카드 수: ${cardCount ?? 0}",
        ),
      ],
    ),
    onTap: tapCallback,
  );
}
