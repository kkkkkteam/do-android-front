import 'package:flutter/material.dart';

class CustomProgressBar extends StatelessWidget {
  final int currentValue; // 현재 값
  final int maxValue; // 최대 값

  const CustomProgressBar({
    required this.currentValue,
    required this.maxValue,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double progress = currentValue / maxValue; // 진행률 계산
    int remainingValue = maxValue - currentValue; // 남은 값 계산

    return Column(
      children: [
        // 프로그레스 바
        Container(
          width: 350, // 고정된 너비
          height: 20, // 높이
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFD9D9D9),width: 1.8),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: progress, // 진행 정도
            child: Container(
              height: 20,
              decoration: BoxDecoration(
                color: const Color(0xFF2E9629), // 내부 도형 초록색 고정
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        // 현재 값 / 최대 값 텍스트
        Text(
          '$currentValue/$maxValue',
          style: const TextStyle(
            color: Color(0xFFD9D9D9),
            fontSize: 11,
            fontFamily: 'NanumGothic',
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 8),
        // 남은 값 텍스트
        Text(
          '다음 레벨까지 경험치 $remainingValue do이 필요해요!',
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFFD9D9D9),
            fontSize: 11,
            fontFamily: 'NanumGothic',
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}
