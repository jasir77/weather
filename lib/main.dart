import 'package:flutter/material.dart';
import 'package:get/get.dart';  // Import GetX package

import 'Routes/App_Pages.dart';
import 'Routes/App_Routes.dart';

void main() {
  runApp(const MyApp());
}

GlobalKey<NavigatorState> navKey = GlobalKey();
GlobalKey<ScaffoldMessengerState> notifKey = GlobalKey();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      initialRoute: AppRoutes.weather,
      debugShowCheckedModeBanner: false,
      getPages: AppPages.Lists,
      navigatorKey: navKey,
      scaffoldMessengerKey: notifKey,
    );
  }
}
