import 'package:flutter/material.dart';

class CustomProgressBar extends StatelessWidget {
  final double currentValue; // 현재 경험치 값
  final String title; // 제목

  const CustomProgressBar({
    Key? key,
    required this.currentValue,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery
        .of(context)
        .size
        .width - 32; // 양쪽 패딩 고려

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 제목 텍스트
        Text(
          '$title 생산성',
          style: const TextStyle(
            fontSize: 18,
            fontFamily: 'Dohyeon',
          ),
        ),
        const SizedBox(height: 8),

        // 경험치 바
        Stack(
          children: [
            // 진행 바
            Container(
              width: screenWidth *
                  ((currentValue > 10 ? 10 : currentValue) / 10).clamp(
                      0.0, 1.0),
              height: 30,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF123524), Color(0xFF3E7B27)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            // 기준선 4.3
            Positioned(
              left: screenWidth * (4.3 / 10),
              child: Container(
                width: 1.5,
                height: 30,
                color: const Color(0xFFB4B4B4),
              ),
            ),
            // 기준선 5.1
            Positioned(
              left: screenWidth * (5.1 / 10),
              child: Container(
                width: 1.5,
                height: 30,
                color: const Color(0xFFB4B4B4),
              ),
            ),
            // 바깥 테두리
            Container(
              width: screenWidth,
              height: 30,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFFB4B4B4),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            // 현재 값 표시
            Positioned(
              right: 10,
              top: 5,
              child: Text(
                currentValue.toStringAsFixed(3),
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'Dohyeon',
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),

        // 기준선 텍스트
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: screenWidth * (4.3 / 10) - 12),
              child: const Text(
                '4.3',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Dohyeon',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: const Text(
                '5.1',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Dohyeon',
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}