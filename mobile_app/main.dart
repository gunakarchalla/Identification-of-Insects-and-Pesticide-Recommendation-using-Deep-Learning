import 'package:flutter/material.dart';
import 'Screens/Pesticide-Suggestion-Screen.dart';
import 'Screens/Insect-Identification-Screen.dart';
import 'Screens/About-Project-Screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bryclay',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/About-Project-Screen",
      routes: {
        "/About-Project-Screen": (ctx) => AboutProjectScreen(),
        "/Insect-Identification-Screen": (ctx) => InsectIdentificationScreen(),
        "/Pesticide-Suggestion-Screen": (ctx) => PesticideSuggestionScreen(),
      },
    );
  }
}
