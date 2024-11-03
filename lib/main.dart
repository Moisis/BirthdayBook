import 'package:flutter/material.dart';
import 'package:lab2/HomeScreen.dart';

import 'package:lab2/favscreen.dart';

import 'UserListScreen.dart';





void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lab2',
      theme: ThemeData(primarySwatch: Colors.blue),
      // home: HomeScreen(),
      initialRoute: '/home',
      routes: {
        '/home': (context) => HomeScreen(),
        '/userlist' : (context) => UserListScreen(),
        '/fav' : (context) => Favscreen(),
      }
    );
  }
}
