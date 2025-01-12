import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final String title; // 게시물 제목
  final String content; // 게시물 내용
  final String author; // 작성자 이름 또는 익명
  final String date; // 작성 날짜
  final Color backgroundColor; // 배경색

  const PostCard({
    required this.title,
    required this.content,
    required this.author,
    required this.date,
    this.backgroundColor = const Color(0xFFF3F3F3), // 기본 배경색
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 3,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor, // 매개변수로 전달된 배경색
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 제목
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontFamily: 'Dohyeon',
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 8),
            // 내용
            Text(
              content,
              style: const TextStyle(
                fontSize: 10,
                fontFamily: 'NanumGothic',
              ),
            ),
            const SizedBox(height: 8),
            // 작성자와 날짜
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  author,
                  style: const TextStyle(
                    fontSize: 7,
                    fontFamily: 'NanumGothic',
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 7,
                    fontFamily: 'NanumGothic',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
