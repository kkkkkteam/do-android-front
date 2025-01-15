import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  int _selectedTab = 0; // 0: 공지사항, 1: 경험치

  // 공지사항 데이터
  final List<Map<String, dynamic>> notices = List.generate(
    10,
        (index) => {
      'title': '공지사항 ${index + 1}',
      'description': '이것은 공지사항 ${index + 1}의 내용입니다. 자세히 확인해주세요.',
      'link': 'https://www.example.com/notice${index + 1}',
      'date': '2025-01-14',
      'time': '19:11',
    },
  );

  // 경험치 데이터
  final List<Map<String, dynamic>> experiences = List.generate(
    10,
        (index) => {
      'title': '경험치 ${index + 1}',
      'description': '이것은 경험치 ${index + 1}의 상세 설명입니다.',
      'points': '+5000 do',
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // 뒤로 가기
          },
        ),
        title: const Text(
          '알림',
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'Dohyeon',
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // 상단 탭
            Container(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildTabButton('공지사항', 0),
                  _buildTabButton('경험치', 1),
                ],
              ),
            ),
            SizedBox(height: 10,),
            const Divider(height: 1, color: Color(0xFFB4B4B4)),
            // 선택된 탭에 따라 다른 위젯 표시
            Expanded(
              child: _selectedTab == 0
                  ? NoticesWidget(notices: notices)
                  : ExperienceWidget(experiences: experiences),
            ),
          ],
        ),
      ),
    );
  }

  // 탭 버튼 빌드 함수
  Widget _buildTabButton(String title, int index) {
    final isSelected = _selectedTab == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTab = index;
        });
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              title,
              style: TextStyle(
                fontFamily: 'NanumGothic',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.black : Colors.grey,
              ),
            ),
          ),
          if (isSelected)
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Color(0xFF2E9629),
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }
}

class NoticesWidget extends StatelessWidget {
  final List<Map<String, dynamic>> notices;

  const NoticesWidget({
    Key? key,
    required this.notices,
  }) : super(key: key);

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: notices.length,
      itemBuilder: (context, index) {
        final notice = notices[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFF2E9629), width: 1.2), // 테두리 두께 변경
          ),
          child: Row(
            children: [
              // 공지사항 텍스트
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notice['title'],
                      style: const TextStyle(
                        fontFamily: 'Dohyeon',
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      notice['description'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        fontFamily: 'NanumGothic',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    GestureDetector(
                      onTap: () => _launchURL(notice['link']),
                      child: Text(
                        notice['link'],
                        style: const TextStyle(fontSize: 12, color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              // 날짜/시간
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    notice['date'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'NanumGothic',
                      fontSize: 10,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    notice['time'],
                    style: const TextStyle(
                      fontFamily: 'NanumGothic',
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class ExperienceWidget extends StatelessWidget {
  final List<Map<String, dynamic>> experiences;

  const ExperienceWidget({
    Key? key,
    required this.experiences,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: experiences.length,
      itemBuilder: (context, index) {
        final experience = experiences[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFF2E9629), width: 1.2), // 테두리 두께 변경
          ),
          child: ListTile(
            title: Text(
              experience['title'],
              style: const TextStyle(fontFamily: 'Dohyeon', fontSize: 18),
            ),
            subtitle: Text(
              experience['description'],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: 'NanumGothic',
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            trailing: Text(
              experience['points'],
              style: const TextStyle(
                fontFamily: 'NanumGothic',
                fontSize: 16,
                color: Color(0xFF2E9629),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}
