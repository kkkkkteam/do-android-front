import 'package:flutter/material.dart';
import '../widgets/user_navigation_bar.dart'; // HomeScreen import
import '../../widgets/custom_textField.dart';
import '../../widgets/custom_button.dart';
import 'package:do_frontend/services/auth_service.dart';
import 'package:do_frontend/utils/token_storage.dart';

class UserLoginScreen extends StatefulWidget {
  const UserLoginScreen({Key? key}) : super(key: key);

  @override
  _UserLoginScreenState createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserLoginScreen> {
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
      final response = await AuthService.login(
        username,
        password,
      );

      if (response == null) {
        setState(() {
          _errorMessage = '로그인에 실패했습니다.';
        });
        return;
      }

      final tokenStorage = TokenStorage();

      await tokenStorage.saveTokens(response.accessToken, response.refreshToken);
      // 로그인 성공 후 화면 전환
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const UserNavigationBar(),
        ),
      );
    } catch (error) {
      String errorMsg = error.toString();
      // "Exception: " 부분 제거
      if (errorMsg.startsWith('Exception: ')) {
        errorMsg = errorMsg.replaceFirst('Exception: ', '');
      }
      setState(() {
        _errorMessage = errorMsg;
      });
      print('Login error: $error'); // 디버깅용 로그
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose(); // 메모리 누수 방지를 위해 dispose 호출
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // 키보드가 올라올 때 화면이 overflow되지 않도록 SingleChildScrollView 추가
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              SizedBox(height: 80), // 상단 여백
              Text(
                '사용자 로그인',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20), // 간격 추가
              // 'do.' 텍스트
              Text(
                'do.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF2E9529),
                  fontSize: 80,
                  fontFamily: 'RubikScribble',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 150), // 입력 필드 전 간격
              // 에러 메시지 표시
              if (_errorMessage != null) ...[
                Text(
                  _errorMessage!,
                  style: TextStyle(color: Colors.red),
                ),
                SizedBox(height: 10),
              ],
              // 아이디 입력 필드
              CustomTextField(
                hintText: '아이디를 입력하세요',
                borderColor: Color(0xFF2E9529),
                maxLines: 1,
                controller: _usernameController,
              ),
              SizedBox(height: 20),
              // 비밀번호 입력 필드
              CustomTextField(
                hintText: '비밀번호를 입력하세요',
                borderColor: Color(0xFF2E9529),
                maxLines: 1,
                obscureText: true,
                controller: _passwordController,
              ),
              SizedBox(height: 40),
              // 로그인 버튼 또는 로딩 인디케이터
              _isLoading
                  ? CircularProgressIndicator(
                color: Color(0xFF2E9529),
              )
                  : CustomButton(
                text: '로그인',
                onPressed: _login,
                color: Color(0xFF2E9529),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
