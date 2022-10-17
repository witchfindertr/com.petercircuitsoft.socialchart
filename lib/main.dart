import 'package:flutter/material.dart';

//for firebase
import 'package:firebase_core/firebase_core.dart';
import 'package:socialchart/navigators/MainNavigator.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const GetMaterialApp(
    title: 'SocialChart',
    home: SocialChart(),
  ));
}

class SocialChart extends StatelessWidget {
  const SocialChart({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: MainNavigator(),
    );
  }
}
