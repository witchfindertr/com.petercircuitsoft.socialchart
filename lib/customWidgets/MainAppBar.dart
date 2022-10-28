import 'package:flutter/material.dart';
import 'package:socialchart/customWidgets/GradientMask.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({required this.title, required this.appBar, required});
  final String title;
  final AppBar appBar;

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: LinearGradientMask(
          child: Text(
        title,
        style: TextStyle(
            fontFamily: "NotoSansKR",
            fontSize: 25,
            fontWeight: FontWeight.w700),
      )),
      actions: [
        TextButton(
          onPressed: () => {},
          child: LinearGradientMask(
            child: Icon(Icons.search, size: 30),
          ),
        ),
      ],
    );
  }
}
