import 'package:flutter/material.dart';

//for firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    title: 'SocialChart',
    home: const SocialChart(),
  ));
}

class SocialChart extends StatelessWidget {
  const SocialChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("소셜 차트")),
        body: Center(
            child: Column(children: [
          Text("Social Chart"),
          Image.asset("assets/images/IMG_4260.png"),
        ])));
  }
}
