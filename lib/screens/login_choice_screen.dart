import 'package:flutter/material.dart';
import 'user_login_screen.dart';
import '../../widgets/custom_button.dart';
import 'admin_login_screen.dart';

class LoginChoiceScreen extends StatelessWidget {
  const LoginChoiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Transform.translate(
              offset: const Offset(0, 130), // 전체 아래로 살짝 이동
              child: Column(
                children: [
                  // 'welcome' 텍스트
                  Text(
                    'welcome',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10), // 간격 추가
                  // 'do.' 텍스트
                  SizedBox(
                    width: 205,
                    child: Text(
                      'do.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF2E9529),
                        fontSize: 100,
                        fontFamily: 'RubikScribble',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: Transform.translate(
                  offset: const Offset(0, 100),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomButton(text: '사용자로 로그인', onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                            builder: (context) => const UserLoginScreen(),));},
                          color: Color(0xFF2E9529)),
                      const SizedBox(height: 20), // 버튼 간 간격
                      CustomButton(
                          text: '관리자로 로그인',
                          onPressed: (){
                            Navigator.push(
                              context,
                                MaterialPageRoute(
                                  builder: (context) => const AdminLoginScreen(),));},
                          textColor: Color(0xFF2E9529), borderColor: Color(0xFF2E9529))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}