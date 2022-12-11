import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socialchart/custom_widgets/gradient_mask.dart';

Widget appbarSearchButton(VoidCallback callback) {
  return CupertinoButton(
    onPressed: callback,
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
