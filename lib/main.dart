import 'package:after_clicks/utils/routes.dart';
import 'package:after_clicks/widgets/themes.dart';
import 'package:flutter/material.dart';

import 'Pages/HomePage.dart';
import 'pages/CollagePage.dart';
import 'pages/EditPage.dart';
import 'pages/SchedulePage.dart';
import 'pages/FilterImage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool whichTheme = true;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      // theme: MyTheme.getLightTheme(context),
      theme: whichTheme
          ? MyTheme.getLightTheme(context)
          : MyTheme.getDarkTheme(context),
      darkTheme: MyTheme.getDarkTheme(context),

      // initialRoute: "/home",
      routes: {
        "/": (context) => HomePage(),
        MyRoutes.homeRoute: (context) => HomePage(),
        MyRoutes.filter: (context) => FilterImagePage(),
        MyRoutes.collage: (context) => CollagePage(),
        MyRoutes.schedule: (context) => SchedulePage(),
        MyRoutes.edit: (context) => EditPage(),
        // MyRoutes.edit: (context) => PredefinedPage(),
      },
    );
  }
}
