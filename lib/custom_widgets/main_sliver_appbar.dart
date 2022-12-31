import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:socialchart/custom_widgets/gradient_mask.dart';
import 'package:socialchart/utils/etc.dart';

class MainSliverAppbar extends SliverAppBar {
  const MainSliverAppbar({
    super.key,
    required this.titleText,
    super.actions,
    super.centerTitle = false,
    super.backgroundColor,
    super.elevation = 0,
    super.floating = true,
    super.automaticallyImplyLeading = false,
    super.titleTextStyle,
    super.systemOverlayStyle,
  });
  final String titleText;

  // @override
  // // TODO: implement systemOverlayStyle
  // SystemUiOverlayStyle? get systemOverlayStyle => SystemUiOverlayStyle.dark;

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
    super.key,
    required this.titleText,
    super.iconTheme,
    super.actions,
    super.centerTitle = false,
    super.backgroundColor,
    super.elevation = 0,
    super.automaticallyImplyLeading = false,
    super.titleTextStyle,
    super.systemOverlayStyle,
  });
  final String titleText;

  @override
  // TODO: implement leading
  Widget? get leading => centerTitle == true
      ? LinearGradientMask(
          child: CupertinoButton(
            padding: EdgeInsets.zero,
            child: const Icon(
              CupertinoIcons.back,
            ),
            onPressed: () => Get.back(),
          ),
        )
      : null;

  @override
  // TODO: implement title
  Widget? get title => LinearGradientMask(
        child: Text(
          titleText,
          style: const TextStyle(
            fontFamily: "NotoSansKR",
            fontSize: 25,
            fontWeight: FontWeight.w700,
          ),
        ),
      );
}
