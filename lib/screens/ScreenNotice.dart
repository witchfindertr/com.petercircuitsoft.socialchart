import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenNotice extends StatelessWidget {
  const ScreenNotice({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notice Screen")),
      body: Center(child: Text("Notice Screen")),
    );
  }
}
