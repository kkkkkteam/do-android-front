import 'package:flutter/material.dart';
import 'screens/admin/admin_main_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AdminMainScreen(), // const 제거
    );
  }
}
