import 'package:flutter/material.dart';

class QuestCard extends StatelessWidget {
  final String quest;
  final String title; // 제목
  final String weight; // 비중
  final String experience; // 경험치
  final String? description; // 설명 (optional)
  final String max; // MAX
  final int maxScore; // MAX 점수
  final String medium; // MEDIUM
  final int mediumScore; // MEDIUM 점수

  const QuestCard({
    Key? key,
    required this.quest,
    required this.title,
    required this.weight,
    required this.experience,
    this.description, // 설명을 nullable로 변경
    required this.max,
    required this.maxScore,
    required this.medium,
    required this.mediumScore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          quest,
          style: const TextStyle(
            fontSize: 18,
            fontFamily: 'Dohyeon',
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFB4B4B4), width: 1.5), // 테두리 두께 1.5로 수정
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 제목과 날짜
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 20, fontFamily: 'Dohyeon'),
                ),
              ),

              // 비중 및 경험치
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  '비중 ${weight}% $experience do',
                  style: const TextStyle(fontSize: 16, fontFamily: 'Dohyeon'),
                ),
              ),

              // 설명 (조건부 표시)
              if (description != null) // 설명이 null이 아닌 경우만 렌더링
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    description!,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontFamily: 'NanumGothic',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

              // MAX 점수와 MEDIUM 점수 테이블
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFB4B4B4), width: 1.5),
                  ),
                  child: Table(
                    border: const TableBorder(
                      horizontalInside: BorderSide(
                        color: Color(0xFFB4B4B4),
                        width: 1.25,
                      ),
                      verticalInside: BorderSide(
                        color: Color(0xFFB4B4B4),
                        width: 1.25,
                      ),
                    ),
                    columnWidths: const {
                      0: FlexColumnWidth(1), // 첫 번째 열
                      1: FlexColumnWidth(1), // 두 번째 열
                    },
                    children: [
                      // 상단 헤더
                      const TableRow(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 12), // 위아래 간격 추가
                            child: Center(
                              child: Text(
                                'MAX 점수',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Dohyeon',
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 12), // 위아래 간격 추가
                            child: Center(
                              child: Text(
                                'MEDIUM 점수',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Dohyeon',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // 점수 데이터
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12), // 위아래 간격 추가
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  max,
                                  style: const TextStyle(
                                      fontFamily: 'NanumGothic',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Text(
                                  '$maxScore', // MEDIUM 점수 매개변수 연동
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'NanumGothic',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12), // 위아래 간격 추가
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  medium,
                                  style: const TextStyle(
                                      fontFamily: 'NanumGothic',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Text(
                                  '$mediumScore', // MEDIUM 점수 매개변수 연동
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'NanumGothic',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
