import 'package:flutter/material.dart';

class CustomExperienceBar extends StatelessWidget {
  final String title; // 제목
  final int firstValue; // 첫 번째 구간 값
  final int secondValue; // 두 번째 구간 값
  final int thirdValue; // 세 번째 구간 값
  final int fourthValue; // 네 번째(최대) 값

  const CustomExperienceBar({
    required this.title,
    required this.firstValue,
    required this.secondValue,
    required this.thirdValue,
    required this.fourthValue,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 진행률 계산
    double totalWidth = 350.0; // 경험치바 전체 너비
    double sectionWidth = totalWidth / 4.0; // 5000마다의 구간 너비

    // 각 구간별 진행률
    double firstProgress = (firstValue / 20000)*totalWidth;
    double secondProgress = (secondValue/20000)*totalWidth;
    double thirdProgress = (thirdValue/20000)*totalWidth;
    double fourthProgress = (fourthValue/20000)*totalWidth;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 타이틀 텍스트
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontFamily: 'Dohyeon',
            color: Color(0xFF000000),
          ),
        ),
        const SizedBox(height: 8),
        // 경험치 바
        Stack(
          children: [
            // 첫 번째 구간
            Positioned(
              left: 0,
              child: Container(
                width: firstProgress,
                height: 30,
                decoration: const BoxDecoration(
                  color: Color(0xFF123524),
                ),
              ),
            ),
            // 두 번째 구간
            Positioned(
              left: firstProgress,
              child: Container(
                width: secondProgress,
                height: 30,
                decoration: const BoxDecoration(
                  color: Color(0xFF3E7B27),
                ),
              ),
            ),
            // 세 번째 구간
            Positioned(
              left: firstProgress+secondProgress,
              child: Container(
                width: thirdProgress,
                height: 30,
                decoration: const BoxDecoration(
                  color: Color(0xFF85A947),
                ),
              ),
            ),
            // 네 번째 구간
            Positioned(
              left: firstProgress+secondProgress+thirdProgress,
              child: Container(
                width: fourthProgress,
                height: 30,
                decoration: const BoxDecoration(
                  color: Color(0xFFEFE3C2),
                ),
              ),
            ),
            // 기준선 5000
            Positioned(
              left: sectionWidth,
              child: Container(
                width: 1.5,
                height: 30,
                color: const Color(0xFFB4B4B4),
              ),
            ),
            // 기준선 10000
            Positioned(
              left: sectionWidth * 2,
              child: Container(
                width: 1.5,
                height: 30,
                color: const Color(0xFFB4B4B4),
              ),
            ),
            // 기준선 15000
            Positioned(
              left: sectionWidth * 3,
              child: Container(
                width: 1.5,
                height: 30,
                color: const Color(0xFFB4B4B4),
              ),
            ),
            Container(
              width: totalWidth,
              height: 30,
              decoration: BoxDecoration(// 바탕색
                border: Border.all(
                  color: const Color(0xFFB4B4B4), // 테두리 색상
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // 하단 텍스트 (5000, 10000, 15000만 표시)
        Row(
          children: [
            SizedBox(width: sectionWidth - 20), // 첫 텍스트 간격 맞추기
            const Text(
              '5,000',
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'Dohyeon',
                color: Color(0xFF000000),
              ),
            ),
            SizedBox(width: sectionWidth - 35), // 두 번째 간격 맞추기
            const Text(
              '10,000',
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'Dohyeon',
                color: Color(0xFF000000),
              ),
            ),
            SizedBox(width: sectionWidth - 45), // 세 번째 간격 맞추기
            const Text(
              '15,000',
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'Dohyeon',
                color: Color(0xFF000000),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
