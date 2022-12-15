/**Flutter basic */
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

/**Firebase */
import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';
import 'firebase_options.dart';

/**Main App */
import 'package:socialchart/socialchart/socialchart.dart';
import 'package:socialchart/socialchart/socialchart_binding.dart';

//for utils
import 'package:socialchart/utils/timeago_custom_messages.dart';
import 'package:timeago/timeago.dart' as timeago;

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  timeago.setLocaleMessages("kr", KrCustomMessages());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
  FlutterNativeSplash.remove();
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
