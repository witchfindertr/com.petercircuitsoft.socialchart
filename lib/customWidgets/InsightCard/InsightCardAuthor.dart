import 'package:flutter/material.dart';

class InsightCardAuthor extends StatelessWidget {
  const InsightCardAuthor(
      {super.key, required this.author, required this.elapsed});
  final String author;
  final String elapsed;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(children: [
      Container(
        child: CircleAvatar(child: Text("avatar")),
      ),
      Container(
          child: Column(
        children: [
          Text(author),
          Text(elapsed),
        ],
      ))
    ]));
  }
}
// /CircleAvatar(child: Text("H"),)