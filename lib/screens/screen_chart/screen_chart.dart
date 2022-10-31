import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialchart/navigators/navigator_constant.dart';

class ScreenChart extends StatelessWidget {
  const ScreenChart({super.key, this.navKey});
  static const routeName = "/ScreenChart";
  final NavKeys? navKey;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chart Screen")),
      body: Center(child: Text("Chart Screen")),
      floatingActionButton: ElevatedButton(
        onPressed: () => {},
        child: Icon(Icons.add),
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          minimumSize: MaterialStateProperty.all<Size?>(
            Size(60, 60),
          ),
          foregroundColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed))
              return Theme.of(context).colorScheme.primary.withOpacity(0.5);
            return null; // Use the component's default.
          }),
        ),
      ),
    );
  }
}
