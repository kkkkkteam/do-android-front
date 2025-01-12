import 'package:flutter/material.dart';
import 'widgets/user_navigation_bar.dart'; // UserNavigationBar import

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const UserNavigationBar(), // UserNavigationBar 사용
    );
  }
}
