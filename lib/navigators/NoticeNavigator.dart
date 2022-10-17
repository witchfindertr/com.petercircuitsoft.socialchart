import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoticeNavigator extends StatelessWidget {
  const NoticeNavigator({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Notice')),
        body: SafeArea(child: Text('Notice')));
  }
}
