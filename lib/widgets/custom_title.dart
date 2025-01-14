import 'package:flutter/material.dart';

class CustomTitle extends StatelessWidget {
  final String title; // 제목 텍스트

  const CustomTitle({
    required this.title, // 제목만 받음
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontFamily: 'Jua',
          ),
        ),
        const SizedBox(height: 8),
        Center(
          child: Container(
            height: 4,
            color: const Color(0xFF2E9529), // 고정된 구분선 색상
          ),
        ),
      ],
    );
  }
}
