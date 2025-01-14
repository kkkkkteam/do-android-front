import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text; // 버튼 텍스트
  final VoidCallback? onPressed; // 클릭 시 동작
  final Color color; // 버튼 색상
  final Color borderColor; // 테두리 색상
  final Color textColor; // 텍스트 색상

  const CustomButton({
    required this.text,
    required this.onPressed,
    this.color = Colors.white,
    this.borderColor = Colors.transparent, // 기본값: 투명
    this.textColor = Colors.white, // 기본값: 흰색
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color, // 버튼 배경색에 color 사용
        minimumSize: const Size(380, 50), // 버튼 크기
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // 모서리 둥글기
          side: BorderSide(color: borderColor, width: 1.0), // 테두리 설정
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor, // 텍스트 색상에 textColor 사용
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontFamily: 'NanumGothic',
        ),
      ),
    );
  }
}
