import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

class UserInterestedChart extends StatelessWidget {
  const UserInterestedChart({super.key, this.userInterestedCharts});
  final List<String>? userInterestedCharts;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      alignment: Alignment.centerLeft,
      child: Column(
        children: [
          Container(alignment: Alignment.centerLeft, child: Text("관심 차트")),
          Container(
              width: double.infinity,
              height: 200,
              // color: Colors.amber,
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
                                            userInterestedCharts![index])))))
                        : SizedBox(
                            height: 100,
                            width: 100,
                            child: Card(child: Text("없어")));
                  },
                  separatorBuilder: (context, index) {
                    return VerticalDivider(
                      color: Colors.black,
                    );
                  },
                  itemCount: userInterestedCharts!.length)),
        ],
      ),
    );
  }
}
