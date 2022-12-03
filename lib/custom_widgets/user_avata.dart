import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:validators/validators.dart';

class CircularPaddedAvatar extends CircleAvatar {
  final double padding;
  const CircularPaddedAvatar({
    Color? backgroundColor,
    ImageProvider? backgroundImage,
    Widget? child,
    double? radius,
    this.padding = 4,
    super.key,
  }) : super(
          backgroundColor: backgroundColor,
          backgroundImage: backgroundImage,
          child: child,
          radius: radius,
        );

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius ?? 0 + padding,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: CircleAvatar(
          // radius: radius,
          minRadius: 30,
          backgroundImage: backgroundImage,
          child: child ?? null,
        ),
      ),
    );
  }
}

Widget userAvatar({
  String? url,
  required String unique,
  double radius = 24,
  double padding = 0,
}) {
  return CircularPaddedAvatar(
    padding: padding,
    radius: radius,
    backgroundImage: isURL(url) ? CachedNetworkImageProvider(url!) : null,
    child: isURL(url) ? null : randomAvatar(unique),
  );
}
