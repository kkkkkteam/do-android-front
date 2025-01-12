import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText; // 텍스트 필드 설명
  final Color borderColor; // 테두리 색상
  final int maxLines; // 최대 줄 수

  const CustomTextField({
    required this.hintText,
    this.borderColor = const Color(0xFFAAAAAA), // 기본 테두리 색상
    this.maxLines = 1, // 기본 줄 수 1
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxLines,
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
