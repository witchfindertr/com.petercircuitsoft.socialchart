import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialchart/custom_widgets/main_appbar.dart';
import 'package:socialchart/app_constant.dart';

class ScreenNotice extends StatelessWidget {
  const ScreenNotice({super.key, this.navKey});
  final NavKeys? navKey;

  static const routeName = '/ScreenNotice';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(appBar: AppBar(), title: "Notice"),
      body: Center(
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.fromLTRB(0, 1, 0, 1),
              child: ListTile(
                leading: CircleAvatar(
                  child: Text("B"),
                ),
                title: Text("Title"),
                subtitle: Text("subtitle"),
                onTap: () => {print("???pressed")},
              ),
            );
          },
        ),
      ),
    );
  }
}
