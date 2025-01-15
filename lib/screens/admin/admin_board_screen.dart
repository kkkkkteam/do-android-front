import 'package:flutter/material.dart';
import 'admin_post_creation.dart';

class AdminBoardScreen extends StatefulWidget {
  const AdminBoardScreen({Key? key}) : super(key: key);

  @override
  _AdminBoardScreenState createState() => _AdminBoardScreenState();
}

class _AdminBoardScreenState extends State<AdminBoardScreen> {
  final List<Map<String, dynamic>> posts = [];
  List<Map<String, dynamic>> filteredPosts = [];
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    filteredPosts = List.from(posts);
  }

  void addPost(String title, String content, bool isUrgent) {
    setState(() {
      posts.insert(0, {
        'title': title,
        'content': content,
        'date': DateTime.now().toString().split(' ')[0],
        'author': isUrgent ? '긴급' : '일반',
      });
      filterPosts(searchQuery);
    });
  }

  void deletePost(int index) {
    setState(() {
      final postToDelete = filteredPosts[index];
      posts.remove(postToDelete);
      filteredPosts.removeAt(index);
    });
  }

  void filterPosts(String query) {
    setState(() {
      searchQuery = query.toLowerCase();
      filteredPosts = posts.where((post) {
        return post['title'].toLowerCase().contains(searchQuery) ||
            post['content'].toLowerCase().contains(searchQuery) ||
            post['author'].toLowerCase().contains(searchQuery);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'do.',
          style: TextStyle(
            fontSize: 30,
            fontFamily: 'RubikScribble',
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                onChanged: filterPosts,
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
                ...filteredPosts.asMap().entries.map((entry) {
                  final index = entry.key;
                  final post = entry.value;
                  return Padding(
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
                        onDelete: () => deletePost(index),
                      ),
                    ),
                  );
                }),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
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
    required VoidCallback onDelete,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: titleStyle,
              ),
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'delete') {
                    onDelete();
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'delete',
                    child: Text('삭제'),
                  ),
                ],
                icon: const Icon(Icons.more_vert, color: Colors.black),
              ),
            ],
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
