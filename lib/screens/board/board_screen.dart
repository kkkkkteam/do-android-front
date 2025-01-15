import 'package:flutter/material.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_post.dart'; // PostCard import
import '../../widgets/search_textField.dart'; // SearchTextField import
import '../../screens/board/article_screen.dart'; // ArticleScreen import
import 'boards_case_screen.dart';
import 'post_creation_screen.dart';

class BoardScreen extends StatefulWidget {
  const BoardScreen({Key? key}) : super(key: key);

  @override
  State<BoardScreen> createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  int _selectedTab = 0; // 0: 사내 게시판, 1: 익명 게시판

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: '게시판'), // CustomAppBar 사용
      body: Column(
        children: [
          // 상단 탭
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTabButton('사내 게시판', 0),
              _buildTabButton('익명 게시판', 1),
            ],
          ),
          const SizedBox(height: 20),
          // 탭에 따른 게시판 화면
          Expanded(
            child: _selectedTab == 0
                ? const CompanyBoardWidget() // 사내 게시판 위젯
                : const AnonyBoardWidget(), // 익명 게시판 위젯
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String title, int index) {
    final isSelected = _selectedTab == index;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedTab = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'NanumGothic',
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            decoration: isSelected ? TextDecoration.underline : null,
            color: isSelected ? Colors.black : Colors.grey,
          ),
        ),
      ),
    );
  }
}
class CompanyBoardWidget extends StatelessWidget {
  const CompanyBoardWidget({Key? key}) : super(key: key);

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
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),

          // 게시판 목록
          const Text(
            '게시판',
            style: TextStyle(fontFamily: 'Dohyeon', fontSize: 18),
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

          // 공지 사항
          const Text(
            '공지 사항',
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'Dohyeon',
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
                    dateTime: DateTime(2025, 1, 22, 14, 30),
                    authorName: '익명',
                  ),
                ),
              );
            },
            child: const PostCard(
              title: '긴급상황: 이것은 제목입니다',
              content: '안녕하세요, 이것은 내용입니다. 감자튀김이 있어요...',
              author: '익명',
              date: '2025.01.22',
            ),
          ),
        ],
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
    return SingleChildScrollView(
      child: Column(
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
      ),
    );
  }
}
class AnonyBoardWidget extends StatefulWidget {
  const AnonyBoardWidget({Key? key}) : super(key: key);

  @override
  State<AnonyBoardWidget> createState() => _AnonyBoardWidgetState();
}

class _AnonyBoardWidgetState extends State<AnonyBoardWidget> {
  final List<Map<String, String>> _posts = [
    {
      'title': '긴급상황: 이것은 제목입니다 0',
      'content': '안녕하세요, 이것은 내용입니다. 감자튀김이 있어요...',
      'author': '익명',
      'date': '2025-01-22',
    },
    {
      'title': '중요 공지: 제목 1',
      'content': '여기는 다른 내용입니다.',
      'author': '관리자',
      'date': '2025-01-20',
    },
    {
      'title': '일상 이야기: 제목 2',
      'content': '오늘은 날씨가 좋습니다.',
      'author': '익명',
      'date': '2025-01-19',
    },
    {
      'title': '제목 3',
      'content': '여기 내용도 추가되었습니다.',
      'author': '홍길동',
      'date': '2025-01-18',
    },
    {
      'title': '공지사항: 제목 4',
      'content': '다른 공지사항입니다.',
      'author': '관리자',
      'date': '2025-01-17',
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              const SizedBox(height: 20),
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