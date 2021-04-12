import 'package:after_clicks/utils/routes.dart';
import 'package:after_clicks/widgets/themes.dart';
import 'package:flutter/material.dart';

import 'Pages/HomePage.dart';
import 'pages/CollagePage.dart';
import 'pages/SchedulePage.dart';
import 'pages/SoloPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: MyTheme.getLightTheme(context),

      darkTheme: MyTheme.getDarkTheme(context),

      // initialRoute: "/home",
      routes: {
        "/": (context) => HomePage(),
        MyRoutes.homeRoute: (context) => HomePage(),
        MyRoutes.solo: (context) => SoloPage(),
        MyRoutes.collage: (context) => CollagePage(),
        MyRoutes.schedule: (context) => SchedulePage(),
      },
    );
  }
}
