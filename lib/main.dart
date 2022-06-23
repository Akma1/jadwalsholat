import 'package:flutter/material.dart';
import 'package:jadwalku/views/page_home.dart';
// import 'package:jadwalku/views/futurecoba.dart';
import 'package:jadwalku/views/test.dart';

void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatelessWidget { 
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Jadwalku",
      // home: TestPage(),
      home: MyHomePage(),
    );
  }
  
}
