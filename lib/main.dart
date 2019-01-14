import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newsapp/UI/HomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.light,

        // Define the default Font Family
        fontFamily: 'Cairo',

      ),
      home: HomePage(),
    );
  }
}
