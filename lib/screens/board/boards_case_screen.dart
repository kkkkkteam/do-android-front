import 'package:flutter/material.dart';
import '../../widgets/custom_back_app_bar.dart'; // CustomBackAppBar import
import 'post_creation_screen.dart'; // PostCreationScreen import
import '../../widgets/search_textField.dart';
import '../../widgets/custom_post.dart'; // PostCard import
import 'article_screen.dart'; // ArticleScreen import
import 'package:intl/intl.dart'; // For date parsing and formatting

class BoardsCaseScreen extends StatefulWidget {
  final String title;

  const BoardsCaseScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<BoardsCaseScreen> createState() => _BoardsCaseScreenState();
}

class _BoardsCaseScreenState extends State<BoardsCaseScreen> {
  // 게시물 데이터
  final List<Map<String, String>> _posts = [
    {
      'title': '긴급상황: 이것은 제목입니다 0',
      'content': '안녕하세요, 이것은 내용입니다. 감자튀김이 있어요...',
      'author': '익명',
      'date': '2025.01.22',
    },
    {
      'title': '중요 공지: 제목 1',
      'content': '여기는 다른 내용입니다.',
      'author': '관리자',
      'date': '2025.01.20',
    },
    {
      'title': '일상 이야기: 제목 2',
      'content': '오늘은 날씨가 좋습니다.',
      'author': '익명',
      'date': '2025.01.19',
    },
    {
      'title': '제목 3',
      'content': '여기 내용도 추가되었습니다.',
      'author': '홍길동',
      'date': '2025.01.18',
    },
    {
      'title': '공지사항: 제목 4',
      'content': '다른 공지사항입니다.',
      'author': '관리자',
      'date': '2025.01.17',
    },
  ];

  // 검색어를 저장할 변수
  String _searchQuery = '';
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 검색 필터를 적용한 게시물 리스트
    final filteredPosts = _posts.where((post) {
      final title = post['title']!.toLowerCase();
      final author = post['author']!.toLowerCase();
      final query = _searchQuery.toLowerCase();
      return title.contains(query) || author.contains(query);
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomBackAppBar(title: widget.title), // 커스텀 AppBar 사용
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 검색 창
              SearchTextField(
                hintText: '게시물의 제목 또는 작성자를 입력하세요',
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
              ),
              const SizedBox(height: 20),

              // 게시물 리스트
              if (filteredPosts.isEmpty)
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
                ...filteredPosts.map(
                      (post) => Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: InkWell(
                      onTap: () {
                        final String dateStr = post['date']!;
                        final DateTime parsedDate = DateFormat('yyyy.MM.dd').parse(dateStr); // 날짜 파싱

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ArticleScreen(
                              title: post['title']!,
                              content: post['content']!,
                              dateTime: parsedDate, // 파싱된 날짜 전달
                              authorName: post['author']!,
                            ),
                          ),
                        );
                      },
                      child: PostCard(
                        title: post['title']!,
                        content: post['content']!,
                        author: post['author']!,
                        date: post['date']!,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newPost = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PostCreationScreen()),
          );

          if (newPost != null && newPost is Map<String, String>) {
            setState(() {
              _posts.insert(0, newPost); // 새 게시물을 맨 앞에 추가
            });
          }
        },
        backgroundColor: const Color(0xFF2E9629),
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
