// ignore_for_file: use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'pages/homepage.dart';
import 'pages/authentication.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/home',
      debugShowCheckedModeBanner: false,
      routes: {
        '/register': (context) => const RegisterScreen(),
        '/login': (context) => SecondScreen(),
        '/home': (context) => const HomePage()
      },
    );
  }
}
