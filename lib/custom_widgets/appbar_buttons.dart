import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialchart/custom_widgets/gradient_mask.dart';
import 'package:socialchart/screens/modal_screen_search/modal_screen_search.dart';
import 'package:socialchart/screens/modal_screen_search/modal_screen_search_binding.dart';

Widget appbarSearchButton({VoidCallback? callback, int? id}) {
  return CupertinoButton(
    onPressed: callback ??
        () => Get.to(
              fullscreenDialog: true,
              id: id,
              binding: ModalScreenSearchBinding(),
              () => ModalScreenSearch(),
            ),
    child: LinearGradientMask(
      child: const Icon(CupertinoIcons.search, size: 26),
    ),
  );
}

Widget appbarAddButton(VoidCallback callback, bool isAdded) {
  return CupertinoButton(
    onPressed: callback,
    child: LinearGradientMask(
      child: Icon(
        isAdded ? CupertinoIcons.check_mark : CupertinoIcons.add,
        size: 26,
      ),
    ),
  );
}

Widget appbarSendButton(VoidCallback? onPressed) {
  return CupertinoButton(
    disabledColor: Colors.black12,
    onPressed: onPressed,
    child: LinearGradientMask(
      child: Icon(CupertinoIcons.paperplane, size: 26),
    ),
  );
}

Widget appbarAddChart(VoidCallback? onPressed) {
  return CupertinoButton(
    disabledColor: Colors.black12,
    onPressed: onPressed,
    child: LinearGradientMask(
      child: Icon(CupertinoIcons.chart_bar_circle, size: 26),
    ),
  );
}
