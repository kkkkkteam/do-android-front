import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final String title;
  final TextStyle titleStyle;
  final String content;
  final TextStyle contentStyle;
  final String date;
  final TextStyle dateStyle;
  final String author;
  final TextStyle authorStyle;

  const PostCard({
    Key? key,
    required this.title,
    required this.titleStyle,
    required this.content,
    required this.contentStyle,
    required this.date,
    required this.dateStyle,
    required this.author,
    required this.authorStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F3F3),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: titleStyle),
          const SizedBox(height: 8),
          Text(content, style: contentStyle),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(author, style: authorStyle),
              const SizedBox(width: 8),
              Text(date, style: dateStyle),
            ],
          ),
        ],
      ),
    );
  }
}
