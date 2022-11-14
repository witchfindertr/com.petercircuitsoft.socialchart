import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socialchart/custom_widgets/gradient_mask.dart';
import 'package:socialchart/utils/etc.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  MainAppBar({
    required this.title,
    required this.appBar,
    this.searchButtonVisible = true,
    this.sendButtonVisible = false,
    this.sendButtonOnPressed,
  });
  final bool searchButtonVisible;
  final bool sendButtonVisible;
  final VoidCallback? sendButtonOnPressed;
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
        searchButtonVisible
            ? CupertinoButton(
                onPressed: () => {},
                child: LinearGradientMask(
                  child: Icon(CupertinoIcons.search, size: 26),
                ),
              )
            : SizedBox(),
        sendButtonVisible
            ? CupertinoButton(
                disabledColor: Colors.black12,
                onPressed: sendButtonOnPressed ?? noCallback(),
                child: LinearGradientMask(
                  child: Icon(CupertinoIcons.paperplane, size: 26),
                ),
              )
            : SizedBox(),
      ],
    );
  }
}
