import 'package:flutter/material.dart';
import 'boards_case_screen.dart'; // 수정된 BoardsCaseScreen으로의 경로
import '../../widgets/custom_app_bar.dart'; // HomeScreen에서 사용한 CustomAppBar 재사용

class BoardScreen extends StatelessWidget {
  const BoardScreen({Key? key}) : super(key: key);

  // 게시판 목록
  static const List<String> boardList = [
    '자유게시판',
    '비밀게시판',
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
                  onTap: () {
                    //사내 게시판 클릭시
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.0),
                    child: Text(
                      '사내 게시판',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Roboto1',
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.underline,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    //익명 게시판 클릭 시
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.0),
                    child: Text(
                      '익명 게시판',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Roboto1',
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
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                    .map((board) => _buildBoardItem(context, board))
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
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            _buildSamplePostCard(),
          ],
        ),
      ),
    );
  }

  // 게시판 항목 생성
  Widget _buildBoardItem(BuildContext context, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BoardsCaseScreen(title: title), // 수정된 BoardsCaseScreen으로 변경
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

  // 샘플 게시물 카드
  Widget _buildSamplePostCard() {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F3F3),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            '긴급상황: 이것은 제목입니다',
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Dohyeon',
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '안녕하세요, 이것은 내용입니다...',
            style: TextStyle(
              fontSize: 10,
              fontFamily: 'NanumGothic',
            ),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '익명',
                style: TextStyle(
                  fontSize: 7,
                  fontFamily: 'NanumGothic',
                ),
              ),
              SizedBox(width: 8),
              Text(
                '2025.01.22',
                style: TextStyle(
                  fontSize: 7,
                  fontFamily: 'NanumGothic',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
