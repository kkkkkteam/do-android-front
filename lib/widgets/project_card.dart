import 'package:flutter/material.dart';

class ProjectCard extends StatelessWidget {
  final String title; // 전체 제목 (e.g., 나의 프로젝트1 (1/12 ~ 3/12))
  final String projectName; // 프로젝트 이름
  final String experience; // 경험치
  final String description; // 설명
  final List<String> participants; // 참여자 이름 리스트

  const ProjectCard({
    Key? key,
    required this.title,
    required this.projectName,
    required this.experience,
    required this.description,
    required this.participants,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 상단 타이틀
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontFamily: 'Dohyeon',
          ),
        ),
        const SizedBox(height: 8), // 간격
        // 카드 본문
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFFB4B4B4),
              width: 1.5,
            ),
          ),
          padding: const EdgeInsets.all(16.0), // 내부 패딩
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 프로젝트 이름
              Text(
                '$projectName 프로젝트',
                style: const TextStyle(
                  fontSize: 20,
                  fontFamily: 'Dohyeon',
                ),
              ),
              const SizedBox(height: 8), // 간격
              // 경험치
              Text(
                '$experience do',
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'Dohyeon',
                ),
              ),
              const SizedBox(height: 12), // 간격
              // 설명
              Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'NanumGothic',
                  fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 8), // 간격
              // 참여자
              Text(
                '참여자: ${participants.join(', ')}',
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'NanumGothic',
                  fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
