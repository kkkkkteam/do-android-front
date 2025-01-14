import 'package:flutter/material.dart';

class CustomProgressBar extends StatelessWidget {
  final double currentValue; // 현재 경험치 값
  final String title;        // 제목

  const CustomProgressBar({
    Key? key,
    required this.currentValue,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 제목 텍스트
        Text(
          title,
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
              width: 480 * ((currentValue > 3000 ? 3000 : currentValue) / 3000).clamp(0.0, 1.0), // 3000 이상이면 최대값으로 고정
              height: 30,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF123524), Color(0xFF3E7B27)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(15), // 둥근 모서리
              ),
            ),
            // 기준선 1000
            Positioned(
              left: 480 * (1000 / 3000), // 기준선 위치 계산
              child: Container(
                width: 1.5,
                height: 30,
                color: const Color(0xFFB4B4B4),
              ),
            ),
            // 기준선 2000
            Positioned(
              left: 480 * (2000 / 3000), // 기준선 위치 계산
              child: Container(
                width: 1.5,
                height: 30,
                color: const Color(0xFFB4B4B4),
              ),
            ),
            // 바깥 테두리
            Container(
              width: 480,
              height: 30,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFFB4B4B4), // 테두리 색상
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            Positioned(
              right: 10, // 진행 바의 오른쪽 끝에 위치
              top: 5, // 진행 바 중앙에 가까운 위치
              child: Text(
                currentValue.toString(),
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'Dohyeon',
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5), // 진행 바와 텍스트 사이 간격
        Row(
          children: [
            // 기준선 텍스트 1000
            Padding(
              padding: EdgeInsets.only(left: 480 * (1000 / 3000) - 12),
              child: const Text(
                '1000',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Dohyeon',
                ),
              ),
            ),
            // 기준선 텍스트 2000
            Padding(
              padding: EdgeInsets.only(left: 120),
              child: const Text(
                '2000',
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
