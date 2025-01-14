import 'package:flutter/material.dart';
import '../../screens/notification/notification_screen.dart';

class ArticleScreen extends StatefulWidget {
  final String title;
  final String content;

  const ArticleScreen({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  _ArticleScreenState createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  int viewCount = 10231;
  DateTime postDate = DateTime(2025, 1, 22, 13, 4);
  TextEditingController _commentController = TextEditingController();
  String currentUserName = "장서인";
  List<Map<String, dynamic>> comments = [];

  void _addCommentOrReply() {
    setState(() {
      if (_commentController.text.isNotEmpty) {
        comments.add({
          "name": currentUserName,
          "time": DateTime.now(),
          "content": _commentController.text,
          "likes": 0,
        });
        _commentController.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = '${postDate.year}.${postDate.month.toString().padLeft(2, '0')}.${postDate.day.toString().padLeft(2, '0')} ${postDate.hour.toString().padLeft(2, '0')}:${postDate.minute.toString().padLeft(2, '0')}';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Center(
          child: const Text(
            'do.',
            style: TextStyle(
              fontFamily: 'RubikScribble',
              color: Color(0xFF2E9529),
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NotificationScreen(),));
            },
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$formattedDate  |  조회 $viewCount',
                style: const TextStyle(fontFamily: 'NanumGothic',fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 8),
              Text(
                widget.title,
                style: const TextStyle(fontFamily: 'Dohyeon', fontSize: 20),
              ),
              const SizedBox(height: 16),
              const Divider(color: Colors.grey),
              const SizedBox(height: 10,),
              Text(
                widget.content,
                style: const TextStyle(fontSize: 14, height: 1.5),
              ),
              const SizedBox(height: 16),
              const Divider(color: Colors.grey),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '댓글 ${comments.length}',
                    style: const TextStyle(fontFamily: 'NanumGothic',fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  PopupMenuButton<String>(
                    onSelected: (value) {},
                    icon: const Icon(Icons.sort, color: Colors.black),
                    itemBuilder: (BuildContext context) {
                      return [
                        PopupMenuItem(
                          value: 'latest',
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.white, // 흰색 배경
                            ),
                            child: const Text('최신 순'),
                          ),
                        ),
                        PopupMenuItem(
                          value: 'mostLiked',
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.white, // 흰색 배경
                            ),
                            child: const Text('좋아요 많은 순'),
                          ),
                        ),
                      ];
                    },
                    color: Colors.white, // PopupMenu 전체 배경 흰색
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Expanded(
                child: comments.isEmpty
                    ? const Center(child: Text('아직 댓글이 없습니다.'))
                    : ListView.builder(
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    final comment = comments[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CircleAvatar(
                              backgroundImage: NetworkImage("https://via.placeholder.com/40"),
                              radius: 20,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    comment["name"],
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(comment["content"]),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Divider(color: Colors.grey),
                      ],
                    );
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _commentController,
                      decoration: const InputDecoration(
                        hintText: '댓글을 입력하세요',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: Color(0xFF2E9529)),
                    onPressed: _addCommentOrReply,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}