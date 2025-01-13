import 'package:flutter/material.dart';
import 'post_creation_page.dart';

class AdminBoardScreen extends StatefulWidget {
  const AdminBoardScreen({Key? key}) : super(key: key);

  @override
  _AdminBoardScreenState createState() => _AdminBoardScreenState();
}

class _AdminBoardScreenState extends State<AdminBoardScreen> {
  // 게시물 리스트
  final List<Map<String, dynamic>> posts = [];

  // 게시물 추가 함수
  void addPost(String title, String content, bool isUrgent) {
    setState(() {
      posts.insert(0, {
        'title': title,
        'content': content,
        'date': DateTime.now().toString().split(' ')[0], // 날짜
        'author': isUrgent ? '긴급' : '일반', // 작성자
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          '공지사항',
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'NanumGothic',
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications, color: Colors.black),
          ),
        ],
      ),
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
                    fontFamily: 'Roboto',
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
              if (posts.isEmpty)
                const Center(
                  child: Text(
                    '등록된 게시물이 없습니다.',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'NanumGothic',
                      color: Colors.grey,
                    ),
                  ),
                )
              else
                ...posts.map((post) => Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: _buildPostCard(
                          title: post['title'],
                          titleStyle: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'Dohyeon',
                            fontWeight: FontWeight.w400,
                          ),
                          content: post['content'],
                          contentStyle: const TextStyle(
                            fontSize: 10,
                            fontFamily: 'NanumGothic',
                          ),
                          date: post['date'],
                          dateStyle: const TextStyle(
                            fontSize: 7,
                            fontFamily: 'NanumGothic',
                          ),
                          author: post['author'],
                          authorStyle: const TextStyle(
                            fontSize: 7,
                            fontFamily: 'NanumGothic',
                          ),
                        ),
                      ),
                    )),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // + 버튼 눌렀을 때 PostCreationPage로 이동 및 결과 받기
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PostCreationPage()),
          );
          if (result != null) {
            addPost(result['title'], result['content'], result['isUrgent']);
          }
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
