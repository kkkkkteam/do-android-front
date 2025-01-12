import 'package:flutter/material.dart';

class CustomPasswordField extends StatelessWidget {
  final TextEditingController controller; // 입력 값을 관리하는 컨트롤러
  final String labelText; // 필드 라벨 텍스트

  const CustomPasswordField({
    required this.controller,
    required this.labelText,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w800,
            fontFamily: 'NanumGothic',
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: const Color(0xFFD9D9D9),
          ),
          child: TextField(
            controller: controller, // 컨트롤러 연결
            decoration: const InputDecoration(border: InputBorder.none),
            obscureText: true, // 비밀번호 텍스트 숨김 처리
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}
