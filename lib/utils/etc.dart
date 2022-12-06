import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

noCallback() {
  try {
    throw ("no callback provided");
  } catch (e, t) {
    print(e);
    print(t);
  }
}

String? completeLinkScheme(String? link) {
  if (link == null) return null;
  Uri uri = Uri.parse(link);
  if (!uri.hasScheme) {
    return "https://$link";
  }
  return link;
}
