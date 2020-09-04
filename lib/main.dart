import 'package:agri_app/login/loginScreen.dart';
import 'package:flutter/material.dart';

import './login/welcome.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      title: 'Agri',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home:WelcomePage(),
      routes: {
        LoginPage.id : (context) => LoginPage(),
      },
      
    );
  }
}