import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text; // 버튼 텍스트
  final VoidCallback? onPressed; // 클릭 시 동작
  final Color color; // 버튼 색상

  const CustomButton({
    required this.text,
    required this.onPressed,
    this.color = Colors.white,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: const Size(350, 50), // 버튼 크기
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          fontFamily: 'NanumGothic',
        ),
      ),
    );
  }
}