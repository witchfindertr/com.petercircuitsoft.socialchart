import 'package:flutter/material.dart';

class UserInterestedChart extends StatelessWidget {
  const UserInterestedChart({super.key, this.userInterestedCharts});
  final List<String>? userInterestedCharts;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          if (index == userInterestedCharts!.length + 1) {
            return Center(
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
            );
          } else {
            return Center(
              child: SizedBox(
                height: 100,
                width: 100,
                child: Card(
                    child: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => {},
                ) //),
                    ),
              ),
            );
          }
        },
        separatorBuilder: (context, index) {
          return const VerticalDivider(
            color: Colors.black,
          );
        },
        itemCount: userInterestedCharts!.length + 1,
      ),
    );
  }
}
