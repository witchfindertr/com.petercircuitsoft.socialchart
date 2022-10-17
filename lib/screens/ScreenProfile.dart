import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenProfile extends StatelessWidget {
  const ScreenProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile Screen")),
      body: Center(child: Text("Profile Screen")),
    );
  }
}
