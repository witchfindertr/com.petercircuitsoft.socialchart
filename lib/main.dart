/**Flutter basic */
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

/**Firebase */
import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';
import 'firebase_options.dart';

/**Google Mobile ads */
import 'package:google_mobile_ads/google_mobile_ads.dart';

/**Main App */
import 'package:socialchart/socialchart/socialchart.dart';
import 'package:socialchart/socialchart/socialchart_binding.dart';

//for utils
import 'package:socialchart/utils/timeago_custom_messages.dart';
import 'package:timeago/timeago.dart' as timeago;

//environment variable
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  //load environment variable
  await dotenv.load(fileName: ".env");

  //ensure binding
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  //preserve the splash screen
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  //set the locale information fo timeago package
  timeago.setLocaleMessages("kr", KrCustomMessages());

  //google mobile ads initialization
  MobileAds.instance.initialize();
  //
  PlatformViewsService.synchronizeToNativeViewHierarchy(false);

  //initialize firebase package
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //remove splash screen after 1 second delay
  await Future.delayed(
    const Duration(seconds: 1),
    () => FlutterNativeSplash.remove(),
  );

  runApp(
    GetMaterialApp(
      title: 'SocialChart',
      theme: ThemeData(
        fontFamily: "NotoSansKR",
        backgroundColor: Colors.grey[300],
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.white,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedItemColor: Colors.blue.shade400),
        scaffoldBackgroundColor: Colors.grey[900],
        backgroundColor: Colors.black,
        cardColor: Colors.grey[900],
        canvasColor: Colors.grey[900],
      ),
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
