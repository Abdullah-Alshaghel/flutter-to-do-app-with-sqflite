import 'package:eltodo/screens/home_screen.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp (
      home: HomeScreen(),
      theme: ThemeData(
        primaryColor: Colors.purple,
      ) ,
    );
  }

}