import 'package:flutter/material.dart';
import '../../widgets/board_upload_app_bar.dart';  // BoardUploadAppBar import
import 'post_creation_page.dart';  // 게시물 작성 페이지 import

class BoardsCaseScreen extends StatelessWidget {
  final String title;

  const BoardsCaseScreen({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BoardUploadAppBar(title: title),  // BoardUploadAppBar 사용
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 검색 창
              TextField(
                decoration: InputDecoration(
                  hintText: '게시물의 제목 또는 작성자를 입력하세요',
                  hintStyle: const TextStyle(
                    fontSize: 15,
                    fontFamily: 'Roboto1',
                    color: Color(0xFFAAAAAA),
                    fontWeight: FontWeight.w400,
                  ),
                  prefixIcon: const Icon(Icons.search, color: Colors.black),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xFF2E9629)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xFF2E9629)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // 게시물 리스트
              ...List.generate(
                5,
                    (index) => Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      onTap: () {
                        print('게시물 $index 클릭됨');
                      },
                      child: _buildPostCard(
                        title: '긴급상황: 이것은 제목입니다',
                        titleStyle: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'Dohyeon',
                          fontWeight: FontWeight.w400,
                        ),
                        content:
                        '안녕하세요, 이것은 내용입니다. 감자튀김이 있어요...',
                        contentStyle: const TextStyle(
                          fontSize: 10,
                          fontFamily: 'NanumGothic',
                        ),
                        date: '2025.01.22',
                        dateStyle: const TextStyle(
                          fontSize: 7,
                          fontFamily: 'NanumGothic',
                        ),
                        author: '익명',
                        authorStyle: const TextStyle(
                          fontSize: 7,
                          fontFamily: 'NanumGothic',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // + 버튼 클릭 시, PostCreationPage로 이동
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PostCreationPage()),  // PostCreationPage로 화면 전환
          );
        },
        backgroundColor: const Color(0xFF2E9629),
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildPostCard({
    required String title,
    required TextStyle titleStyle,
    required String content,
    required TextStyle contentStyle,
    required String date,
    required TextStyle dateStyle,
    required String author,
    required TextStyle authorStyle,
  }) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F3F3),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: titleStyle,
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: contentStyle,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                author,
                style: authorStyle,
              ),
              const SizedBox(width: 8),
              Text(
                date,
                style: dateStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
