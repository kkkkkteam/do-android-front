import 'package:flutter/material.dart';
import 'screens/login_choice_screen.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // 비동기 작업을 위한 초기화
  await initializeDateFormatting('ko_KR', null); // 한국어('ko_KR')로 초기화
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginChoiceScreen(),
    );
  }
}
