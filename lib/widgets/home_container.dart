import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final String title; // 오른쪽 텍스트
  final Widget child; // 자식 위젯

  const CustomContainer({
    Key? key,
    required this.title,
    required this.child, // child를 매개변수로 받음
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 오른쪽 텍스트 (왼쪽 정렬)
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontFamily: 'Dohyeon',
            ),
          ),
        ),
        const SizedBox(height: 8), // 텍스트와 컨테이너 간 여백
        Container(
          decoration: BoxDecoration(
            color: Colors.white, // 배경 색상
            border: Border.all(color: Color(0xFFB4B4B4), width: 1.5), // 테두리 색상과 두께
            borderRadius: BorderRadius.circular(12), // 둥근 모서리
          ),
          child: child, // 매개변수로 받은 child 사용
        ),
      ],
    );
  }
}
