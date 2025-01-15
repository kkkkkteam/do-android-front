import 'package:flutter/material.dart';
import '../widgets/admin_navigation_bar.dart';
import '../../widgets/custom_textField.dart';
import '../../widgets/custom_button.dart';
import 'login_choice_screen.dart'; // LoginChoiceScreen import

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({Key? key}) : super(key: key);

  @override
  _AdminLoginScreenState createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;

  void _login() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text;

    // 간단한 폼 유효성 검사
    if (username.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage = '아이디와 비밀번호를 모두 입력하세요.';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // 로그인 로직 수행 (로그인 성공 시 네비게이션 이동)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const AdminNavigationBar(),
        ),
      );
    } catch (error) {
      setState(() {
        _errorMessage = '로그인에 실패했습니다.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  const SizedBox(height: 80), // 상단 여백
                  const Text(
                    '관리자 로그인',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20), // 간격 추가
                  const Text(
                    'do.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF2E9529),
                      fontSize: 100,
                      fontFamily: 'RubikScribble',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 150), // 입력 필드 전 간격
                  if (_errorMessage != null) ...[
                    Text(
                      _errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 10),
                  ],
                  CustomTextField(
                    hintText: '아이디를 입력하세요',
                    borderColor: const Color(0xFF2E9529),
                    maxLines: 1,
                    controller: _usernameController,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    hintText: '비밀번호를 입력하세요',
                    borderColor: const Color(0xFF2E9529),
                    maxLines: 1,
                    obscureText: true,
                    controller: _passwordController,
                  ),
                  const SizedBox(height: 40),
                  _isLoading
                      ? const CircularProgressIndicator(
                    color: Color(0xFF2E9529),
                  )
                      : CustomButton(
                    text: '로그인',
                    onPressed: _login,
                    color: const Color(0xFF2E9529),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 10, // 왼쪽 위에 위치
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginChoiceScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}