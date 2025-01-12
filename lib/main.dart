import 'package:flutter/material.dart';
import 'package:do_frontend/screens/models/auth.dart';
import 'package:do_frontend/screens/profile/auth_profile_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Auth auth = Auth(
      name: "조폭",
      id: "32240704",
      department: "칠성파",
      joinDate: "2001.12.24",
      jobGroup: "물구나무서기 선생님",
      yearlyExperience: {
        "2023년": 6000,
        "2022년": 7000,
        "2021년": 4000,
      },
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthProfileScreen(auth: auth),
    );
  }
}
