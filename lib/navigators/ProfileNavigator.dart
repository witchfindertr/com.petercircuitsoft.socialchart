import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileNavigator extends StatelessWidget {
  const ProfileNavigator({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Profile')),
        body: SafeArea(child: Text('Profile')));
  }
}
