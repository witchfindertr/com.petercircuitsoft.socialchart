import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:validators/validators.dart';

Widget userAvata(String? url, String key) {
  return CircleAvatar(
    minRadius: 24,
    backgroundImage: isURL(url) ? CachedNetworkImageProvider(url!) : null,
    child: isURL(url) ? null : randomAvatar(key),
  );
}
