import 'package:flutter/material.dart';
import 'package:socialchart/customWidgets/AssetAndPrice.dart';

class InsightCardHeader extends StatelessWidget {
  const InsightCardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return EventCardHeader(eventName: "바이든 지지율");
    // return AssetCardHeader();
  }
}

class AssetCardHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
                child: AssetAndPrice(
              text: "ALGO",
              price: 500,
              color: Color.fromARGB(255, 0, 34, 255),
            )),
            Center(
                child: AssetAndPrice(
              text: "ALGO",
              price: 500,
            )),
            Center(
                child: AssetAndPrice(
                    text: "ALGO",
                    price: 500,
                    color: 500 > 0 ? Colors.red : Colors.black)),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
                child: AssetAndPrice(
              text: "ALGO",
              price: 500,
            )),
            Center(
                child: AssetAndPrice(
              text: "ALGO",
              price: 500,
            )),
            Center(
                child: AssetAndPrice(
              text: "ALGO",
              price: 500,
            )),
          ],
        )
      ],
    );
  }
}

class EventCardHeader extends StatelessWidget {
  const EventCardHeader({super.key, required this.eventName});
  final String eventName;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print(eventName),
      child: Container(
        //color: Colors.amber,
        padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
        child: Column(
          children: [
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: arrayToRichText(
                      [
                        "📈",
                        "${eventName}",
                        "",
                      ],
                      TextStyle(height: 1, fontSize: 12),
                    ),
                  ),
                  Container(
                    child: Text(
                      "마지막 이벤트: 1598년 12월 16일",
                      style: TextStyle(height: 1, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 5,
              color: Colors.blueGrey.withOpacity(0.5),
            ),
            Center(
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      maxLines: 1,
                      "\"나의 죽음을 알리지 말라.\" 이순신은 1598년 조선에서 철군하는 일본군을 추격하여 노량 해전을 치르던 중 총탄에 맞아 전사했다. 죽음을 함구하고 전투를 지속하라는 말을 남겼고 그가 죽은 뒤에 전투는 승리로 끝났으며 그와 함께 일본-조선-명이 얽힌 지옥도와 같았던 전쟁도 끝났다.",
                      style: TextStyle(height: 1, fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget arrayToRichText(List<String> arry, TextStyle style) {
  return Text.rich(
    TextSpan(
      children: arry
          .map((e) => TextSpan(
                semanticsLabel: "asdfaf",
                text: e,
                style: style,
              ))
          .toList(),
    ),
  );
}
