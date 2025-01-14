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
          '$title 생산성', // 동적으로 전달된 제목 사용
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
              width: 480 * ((currentValue > 10 ? 10 : currentValue) / 10).clamp(0.0, 1.0), // 10 이상이면 최대값으로 고정
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
            // 기준선 4.3
            Positioned(
              left: 480 * (4.3 / 10), // 기준선 위치 계산
              child: Container(
                width: 1.5,
                height: 30,
                color: const Color(0xFFB4B4B4),
              ),
            ),
            // 기준선 5.1
            Positioned(
              left: 480 * (5.1 / 10), // 기준선 위치 계산
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
                currentValue.toStringAsFixed(3), // 소수점 3자리까지 표시
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
            // 기준선 텍스트 4.3
            Padding(
              padding: EdgeInsets.only(left: 480 * (4.3 / 10) - 12),
              child: const Text(
                '4.3',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Dohyeon',
                ),
              ),
            ),
            // 기준선 텍스트 5.1
            Padding(
              padding: const EdgeInsets.only(left: 20),
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
