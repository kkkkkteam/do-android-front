import 'package:flutter/material.dart';
import '../../widgets/custom_app_bar.dart'; // CustomBackAppBar import
import 'post_creation_screen.dart'; // PostCreationScreen import
import '../../widgets/search_textField.dart';
import '../../widgets/custom_post.dart'; // PostCard import
import 'article_screen.dart'; // ArticleScreen import
import '../../widgets/user_navigation_bar.dart';

class AnonyBoardScreen extends StatefulWidget {
  const AnonyBoardScreen({Key? key}) : super(key: key);

  @override
  State<AnonyBoardScreen> createState() => _BoardsCaseScreenState();
}

class _BoardsCaseScreenState extends State<AnonyBoardScreen> {
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
    final filteredPosts = _posts.where((post) {
      final title = post['title']!.toLowerCase();
      final author = post['author']!.toLowerCase();
      final query = _searchQuery.toLowerCase();
      return title.contains(query) || author.contains(query);
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: '익명 게시판'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const UserNavigationBar(
                              initialIndex: 1,
                            ),
                          ));
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40.0),
                      child: Text(
                        '사내 게시판',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'NanumGothic',
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40.0),
                      child: Text(
                        '익명 게시판',
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
                ],
              ),
              const SizedBox(height: 30),
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
              ...filteredPosts.map(
                    (post) => Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ArticleScreen(
                            title: post['title']!,
                            content: post['content']!,
                            dateTime: DateTime.parse(post['date']!),
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
