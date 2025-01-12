import 'package:flutter/material.dart';
import '../../widgets/custom_password_field.dart'; // 비밀번호 입력 필드
import '../../widgets/custom_button.dart'; // 공통 버튼 위젯

class PasswordChangeScreen extends StatefulWidget {
  const PasswordChangeScreen({Key? key}) : super(key: key);

  @override
  State<PasswordChangeScreen> createState() => _PasswordChangeScreenState();
}

class _PasswordChangeScreenState extends State<PasswordChangeScreen> {
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isButtonEnabled = false; // 버튼 활성화 상태

  // 입력 값 변경 시 호출되는 메서드
  void _onInputChange() {
    final currentPassword = _currentPasswordController.text;
    final newPassword = _newPasswordController.text;
    final confirmPassword = _confirmPasswordController.text;

    // 유효성 검증: 모든 입력 필드가 비어있지 않고 새 비밀번호와 확인 비밀번호가 일치할 때
    setState(() {
      _isButtonEnabled = currentPassword.isNotEmpty &&
          newPassword.isNotEmpty &&
          confirmPassword.isNotEmpty &&
          newPassword == confirmPassword &&
          newPassword.length >= 6; // 새 비밀번호 최소 길이 조건
    });
  }

  @override
  void initState() {
    super.initState();
    // 입력 필드 컨트롤러에 리스너 추가
    _currentPasswordController.addListener(_onInputChange);
    _newPasswordController.addListener(_onInputChange);
    _confirmPasswordController.addListener(_onInputChange);
  }

  @override
  void dispose() {
    // 컨트롤러 해제
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          '비밀번호 변경',
          style: TextStyle(
            fontSize: 14,
            fontFamily: 'NanumGothic',
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // AppBar 아래 회색 경계선
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Color(0xFFD9D9D9), width: 1.5)),
              ),
            ),
            const SizedBox(height: 30),

            // 비밀번호 변경 입력 필드
            SizedBox(
              width: 350,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '비밀번호 입력',
                    style: TextStyle(fontSize: 20, fontFamily: 'Jua'),
                  ),
                  const SizedBox(height: 15),
                  const Divider(color: Color(0xFF2E9528), thickness: 4),
                  const SizedBox(height: 50),
                  CustomPasswordField(
                    controller: _currentPasswordController,
                    labelText: '현재 비밀번호',
                  ),
                  CustomPasswordField(
                    controller: _newPasswordController,
                    labelText: '새 비밀번호',
                  ),
                  CustomPasswordField(
                    controller: _confirmPasswordController,
                    labelText: '새 비밀번호 확인',
                  ),
                  const SizedBox(height: 30),
                  CustomButton(
                    text: '변경',
                    onPressed: _isButtonEnabled
                        ? () {
                      // 변경 버튼 클릭 동작
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('비밀번호가 변경되었습니다!')),
                      );
                    }
                        : null, // 버튼 비활성화 시 동작 없음
                    color: _isButtonEnabled ? const Color(0xFF2E9629) : Colors.grey,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
