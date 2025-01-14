import 'package:flutter/material.dart';
import 'boards_case_screen.dart'; // BoardsCaseScreen import
import '../../widgets/custom_app_bar.dart'; // CustomAppBar import
import '../../widgets/custom_post.dart'; // PostCard import
import 'article_screen.dart';
import 'anony_board_screen.dart';

class BoardScreen extends StatelessWidget {
  const BoardScreen({Key? key}) : super(key: key);

  // 게시판 목록
  static const List<String> boardList = [
    '전체게시판',
    '음성1센터 게시판',
    '음성2센터 게시판',
    '용인백암센터 게시판',
    '남양주센터 게시판',
    '파주센터 게시판',
    '그로스팀 게시판',
    '사업기획팀 게시판',
    'CX팀 게시판',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: '홈'), // CustomAppBar 사용
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 상단 탭
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.0),
                    child: Text(
                      '사내 게시판',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'NanumGothic',
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AnonyBoardScreen(),));
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.0),
                    child: Text(
                      '익명 게시판',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'NanumGothic',
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // 게시판 목록
            const Text(
              '게시판',
              style: TextStyle(fontFamily: 'NanumGothic',fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F3F3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: boardList
                    .map((board) => BoardItem(title: board)) // BoardItem 위젯 사용
                    .toList(),
              ),
            ),
            const SizedBox(height: 30),

            // 실시간 인기 글
            const Text(
              '실시간 인기 글',
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'NanumGothic',
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ArticleScreen(
                      title: '긴급상황: 이것은 제목입니다',
                      content: '안녕하세요, 이것은 내용입니다. 감자튀김이 있어요...',
                    ),
                  ),
                );
              },
              child: PostCard(
                title: '긴급상황: 이것은 제목입니다',
                content: '안녕하세요, 이것은 내용입니다. 감자튀김이 있어요...',
                author: '익명',
                date: '2025.01.22',
              ),
            ),

          ],
        ),
      ),
    );
  }
}

// 게시판 항목 위젯
class BoardItem extends StatelessWidget {
  final String title;

  const BoardItem({required this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BoardsCaseScreen(title: title),
              ),
            );
          },
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 13,
              fontFamily: 'NanumGothic',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const Divider(color: Color(0xFFF3F3F3)),
      ],
    );
  }
}