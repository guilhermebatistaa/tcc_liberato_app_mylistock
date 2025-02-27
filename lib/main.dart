import 'package:flutter/material.dart';
import 'package:my_app/data/item_inherited.dart';
import 'package:my_app/screens/initial_screen.dart';
import 'package:my_app/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: LoginScreen(),

      // home: ItemInherited(
      //   child: const InitialScreen(),
      // ),
    );
  }
}
