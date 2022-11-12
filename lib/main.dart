/**Flutter basic */
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/**Firebase */
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

/**Main App */
import 'package:socialchart/socialchart/socialchart.dart';
import 'package:socialchart/socialchart/socialchart_binding.dart';

//for utils
import 'package:socialchart/utils/timeago_custom_messages.dart';
import 'package:timeago/timeago.dart' as timeago;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  timeago.setLocaleMessages("kr", KrCustomMessages());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    GetMaterialApp(
      title: 'SocialChart',
      theme: ThemeData(fontFamily: "NotoSansKR"),
      initialRoute: "/",
      getPages: [
        GetPage(
          name: "/",
          page: () => SocialChart(),
          binding: SocialChartBinding(),
        ),
      ],
    ),
  );
}
