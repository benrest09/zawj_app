import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:zawj_app/main_screen.dart';
import 'package:zawj_app/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: .fromSeed(
          seedColor: const Color.fromARGB(255, 255, 237, 252),
        ),
      ),
      home: SplashScreen(),
    );
  }
}
