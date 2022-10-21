import 'package:flutter/material.dart';

class InsightCardAuthor extends StatelessWidget {
  const InsightCardAuthor({
    super.key,
    required this.author,
    required this.elapsed,
  });
  final String author;
  final String elapsed;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          child: Text("avatar"),
        ),
        Column(
          children: [
            Text(author),
            Text(elapsed),
          ],
        ),
      ],
    );
  }
}
