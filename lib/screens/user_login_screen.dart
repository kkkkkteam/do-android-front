import 'package:flutter/material.dart';
import '../widgets/user_navigation_bar.dart'; // HomeScreen import
import '../../widgets/custom_textField.dart';
import '../../widgets/custom_button.dart';

class UserLoginScreen extends StatefulWidget {
  const UserLoginScreen({Key? key}) : super(key: key);

  @override
  _UserLoginScreenState createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserLoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose(); // 메모리 누수 방지를 위해 dispose 호출
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Transform.translate(
            offset: const Offset(0, 40), // 상단 텍스트 위치 조정
            child: Column(
              children: [
                Text(
                  '사용자 로그인',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30), // 간격 추가
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
                offset: const Offset(0, 40), // 입력 필드를 중앙 근처에 배치
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      // 아이디 입력 필드
                      SizedBox(height: 150,),
                      CustomTextField(hintText: '아이디를 입력하세요', borderColor: Color(0xFF2E9529), maxLines: 1, controller: _usernameController,),
                      SizedBox(height: 30,),
                      // 비밀번호 입력 필드
                      CustomTextField(hintText: '비밀번호를 입력하세요', borderColor: Color(0xFF2E9529), maxLines: 1, obscureText: true, controller: _passwordController,),
                      SizedBox(height: 60,),
                      // 로그인 버튼
                      CustomButton(text: '로그인', onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const UserNavigationBar(),
                          ),
                        );
                      }, color: Color(0xFF2E9529))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}