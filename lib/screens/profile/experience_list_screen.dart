import 'package:flutter/material.dart';
import '../../widgets/custom_section.dart';
import '../../widgets/custom_title.dart';
import '../../widgets/custom_back_app_bar.dart';

class ExperienceListScreen extends StatelessWidget {
  const ExperienceListScreen({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> experienceData = const [
    {"date": "2024-02-01", "title": "상반기 인사평가", "score": "1500 do"},
    {"date": "2024-03-01", "title": "상반기 프로젝트 완료", "score": "2000 do"},
    {"date": "2024-04-01", "title": "기술 세미나 발표", "score": "1200 do"},
    {"date": "2024-05-01", "title": "코드 리뷰 기여", "score": "900 do"},
    {"date": "2024-06-01", "title": "팀워크 향상", "score": "1300 do"},
    {"date": "2024-07-01", "title": "하반기 프로젝트 시작", "score": "1700 do"},
    {"date": "2024-08-01", "title": "개인 기술 블로그 작성", "score": "800 do"},
    {"date": "2024-09-01", "title": "기술 워크숍 참가", "score": "1100 do"},
    {"date": "2024-10-01", "title": "하반기 프로젝트 완료", "score": "2500 do"},
    {"date": "2024-11-01", "title": "연말 목표 달성", "score": "3000 do"},
  ];

  @override
  Widget build(BuildContext context) {
    // 경험치 데이터를 CustomSection 형식에 맞게 변환
    final List<Map<String, dynamic>> sectionItems = experienceData.map((data) {
      return {
        'title': data['date'],
        'value': '${data['title']} (${data['score']})',
      };
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomBackAppBar(title: '경험치 내역 확인'),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: CustomSection(
            title: '경험치 내역',
            initialItems: sectionItems,
          ),
        ),
      ),
    );
  }
}
