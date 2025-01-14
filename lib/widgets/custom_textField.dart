import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText; // 텍스트 필드 설명
  final Color borderColor; // 테두리 색상
  final int maxLines; // 최대 줄 수
  final TextEditingController? controller; // 텍스트 필드 컨트롤러
  final bool obscureText; // 비밀번호 입력을 숨길지 여부

  const CustomTextField({
    required this.hintText,
    this.borderColor = const Color(0xFFAAAAAA), // 기본 테두리 색상
    this.maxLines = 1, // 기본 줄 수 1
    this.controller, // 컨트롤러 추가
    this.obscureText = false, // 기본값은 false
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller, // 컨트롤러 연결
      maxLines: maxLines,
      obscureText: obscureText, // 텍스트 숨기기 설정
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: borderColor, width: 1), // 테두리 색상
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: borderColor, width: 1), // 비활성 테두리
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: borderColor, width: 1), // 활성화 테두리
        ),
      ),
    );
  }
}
