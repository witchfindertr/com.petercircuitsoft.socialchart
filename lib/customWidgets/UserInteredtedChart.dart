import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

class UserInterestedChart extends StatelessWidget {
  const UserInterestedChart({super.key, this.userInterestedCharts});
  final List<String>? userInterestedCharts;
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          width: double.infinity,
          child: Text(
            "내 관심 차트",
            style: Theme.of(context).textTheme.headline5,
          )),
      Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          height: 100,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return userInterestedCharts!.isNotEmpty
                    ? Center(
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: Card(
                            child: TextButton(
                              onPressed: () => {},
                              child: Text(
                                userInterestedCharts![index],
                              ),
                            ),
                          ),
                        ),
                      )
                    : SizedBox(
                        height: 100,
                        width: 100,
                        child: Card(
                          child: Text("없어"),
                        ),
                      );
              },
              separatorBuilder: (context, index) {
                return VerticalDivider(
                  color: Colors.black,
                );
              },
              itemCount: userInterestedCharts!.length))
    ]);
  }
}
