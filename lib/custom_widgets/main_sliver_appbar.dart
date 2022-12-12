import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socialchart/custom_widgets/gradient_mask.dart';
import 'package:socialchart/utils/etc.dart';

class MainSliverAppbar extends SliverAppBar {
  MainSliverAppbar({
    required this.titleText,
    super.actions,
    super.centerTitle = false,
    super.backgroundColor,
    super.elevation = 0,
    super.floating = true,
    super.automaticallyImplyLeading = false,
  });
  final String titleText;

  @override
  // TODO: implement title
  Widget? get title => LinearGradientMask(
        child: Text(
          titleText,
          style: const TextStyle(
              fontFamily: "NotoSansKR",
              fontSize: 25,
              fontWeight: FontWeight.w700),
        ),
      );
}

class MainAppbar extends AppBar {
  MainAppbar({
    required this.titleText,
    super.leading,
    super.actions,
    super.centerTitle = false,
    super.backgroundColor,
    super.elevation = 0,
    super.automaticallyImplyLeading = false,
  });
  final String titleText;

  @override
  // TODO: implement title
  Widget? get title => LinearGradientMask(
        child: Text(
          titleText,
          style: const TextStyle(
              fontFamily: "NotoSansKR",
              fontSize: 25,
              fontWeight: FontWeight.w700),
        ),
      );
}
