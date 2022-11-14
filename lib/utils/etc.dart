import 'package:flutter/material.dart';

noCallback() {
  try {
    throw ("no callback provided");
  } catch (e, t) {
    print(e);
    print(t);
  }
}
