import 'package:flutter/material.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/post_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: '홈'),
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
                  onTap: () {
                    print('사내 게시판 클릭됨');
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.0),
                    child: Text(
                      '사내 게시판',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.underline,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    print('익명 게시판 클릭됨');
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.0),
                    child: Text(
                      '익명 게시판',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // 게시판 목록
            const Text('게시판', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F3F3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBoardItem('자유게시판'),
                  _buildBoardItem('비밀게시판'),
                  _buildBoardItem('음성1센터 게시판'),
                  _buildBoardItem('음성2센터 게시판'),
                  _buildBoardItem('용인백암센터 게시판'),
                  _buildBoardItem('남양주센터 게시판'),
                  _buildBoardItem('파주센터 게시판'),
                  _buildBoardItem('그로스팀 게시판'),
                  _buildBoardItem('사업기획팀 게시판'),
                  _buildBoardItem('CX팀 게시판'),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // 실시간 인기 글
            const Text(
              '실시간 인기 글',
              style: TextStyle(fontSize: 18, fontFamily: 'NanumGothic', fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            PostCard(
              title: '긴급상황: 이것은 제목입니다',
              titleStyle: const TextStyle(fontSize: 16, fontFamily: 'Dohyeon', fontWeight: FontWeight.w400),
              content: '안녕하세요 이것은 내용입니다...',
              contentStyle: const TextStyle(fontSize: 10, fontFamily: 'NanumGothic'),
              date: '2025.01.22',
              dateStyle: const TextStyle(fontSize: 7, fontFamily: 'NanumGothic'),
              author: '익명',
              authorStyle: const TextStyle(fontSize: 7, fontFamily: 'NanumGothic'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBoardItem(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => print('$title 클릭됨'),
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
