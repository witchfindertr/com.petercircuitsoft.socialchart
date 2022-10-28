import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ScreenTestArgs {
  int? num;
  ScreenTestArgs({this.num});
}

class ScreenTest extends StatelessWidget {
  const ScreenTest({super.key});
  static const routeName = '/ScreenTest';

  @override
  Widget build(BuildContext context) {
    var number = ModalRoute.of(context)!.settings.arguments as ScreenTestArgs?;
    print(number?.num.toString());
    return Container(child: Center(child: Text("none")));
  }
}
