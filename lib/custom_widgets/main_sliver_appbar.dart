import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socialchart/utils/etc.dart';

class MainSliverAppbar extends StatelessWidget {
  const MainSliverAppbar({
    super.key,
    required this.titleText,
    this.searchButtonVisible = true,
    this.sendButtonVisible = false,
    this.sendButtonOnPressed,
  });

  final bool searchButtonVisible;
  final bool sendButtonVisible;
  final VoidCallback? sendButtonOnPressed;
  final String titleText;

  Widget get title => LinearGradientMask(
        child: Text(
          titleText,
          style: const TextStyle(
              fontFamily: "NotoSansKR",
              fontSize: 25,
              fontWeight: FontWeight.w700),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return SliverSafeArea(
      sliver: SliverAppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: title,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: false,
        floating: true,
        // snap: true,
        actions: [
          searchButtonVisible
              ? CupertinoButton(
                  onPressed: () => {},
                  child: LinearGradientMask(
                    child: const Icon(CupertinoIcons.search, size: 26),
                  ),
                )
              : const SizedBox(),
          sendButtonVisible
              ? CupertinoButton(
                  disabledColor: Colors.black12,
                  onPressed: sendButtonOnPressed ?? noCallback(),
                  child: LinearGradientMask(
                    child: const Icon(CupertinoIcons.paperplane, size: 26),
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}

class LinearGradientMask extends StatelessWidget {
  const LinearGradientMask({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color.fromRGBO(0xab, 0x4e, 0x86, 1),
          Color.fromRGBO(0x31, 0x2f, 0xa5, 1),
          Color.fromRGBO(0x96, 0x0b, 0xd8, 1),
        ],
        tileMode: TileMode.mirror,
      ).createShader(bounds),
      child: child,
    );
  }
}
