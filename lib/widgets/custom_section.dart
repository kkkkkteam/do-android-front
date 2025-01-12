import 'package:flutter/material.dart';

class CustomSection extends StatelessWidget {
  final String title; // 섹션 제목
  final List<Map<String, dynamic>> items; // 섹션 아이템 리스트

  const CustomSection({required this.title, required this.items, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20), // 좌우 여백 추가
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 섹션 제목
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontFamily: 'Jua',
            ),
          ),
          const SizedBox(height: 8),
          // 섹션 구분선
          Container(
            width: double.infinity,
            height: 4,
            color: const Color(0xFF2E9528),
          ),
          const SizedBox(height: 12),
          // 섹션 아이템 리스트
          ...items.map((item) => _buildItem(item)).toList(),
        ],
      ),
    );
  }

  Widget _buildItem(Map<String, dynamic> item) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 제목
            Expanded(
              flex: 2,
              child: Text(
                item['title'],
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontFamily: 'NanumGothic',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            // 값 및 아이콘
            Expanded(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    item['value'],
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'NanumGothic',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  if (item.containsKey('icon')) // 아이콘이 있는 경우만 표시
                    IconButton(
                      onPressed: item['onPressed'],
                      icon: item['icon'],
                      iconSize: 18,
                      color: Colors.grey,
                    ),
                ],
              ),
            ),
          ],
        ),
        const Divider(color: Color(0xFFD9D9D9), thickness: 1),
      ],
    );
  }
}
