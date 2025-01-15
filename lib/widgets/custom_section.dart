import 'package:flutter/material.dart';

class CustomSection extends StatefulWidget {
  final String title; // 섹션 제목
  final List<Map<String, dynamic>> initialItems; // 초기 섹션 아이템 리스트

  const CustomSection({
    required this.title,
    required this.initialItems,
    Key? key,
  }) : super(key: key);

  @override
  _CustomSectionState createState() => _CustomSectionState();
}

class _CustomSectionState extends State<CustomSection> {
  late List<Map<String, dynamic>> items; // 동적으로 관리될 아이템 리스트

  @override
  void initState() {
    super.initState();
    items = List.from(widget.initialItems); // 초기 아이템 설정
  }

  void addItem(Map<String, dynamic> newItem) {
    setState(() {
      items.add(newItem); // 새 아이템 추가
      if (items.length > 50) {
        items.removeAt(0); // 크기가 50을 초과하면 첫 번째 아이템 삭제
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20), // 좌우 여백 추가
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 섹션 제목
          Text(
            widget.title,
            style: const TextStyle(
              fontSize: 18,
              fontFamily: 'Dohyeon',
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
          // 아이템 리스트
          ListView.builder(
            shrinkWrap: true, // 부모 위젯의 크기를 초과하지 않도록 설정
            physics: const NeverScrollableScrollPhysics(), // 스크롤 비활성화 (외부 스크롤 사용)
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Column(
                children: [
                  if (!item.containsKey('icon'))
                    SizedBox(height: 10,),
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
                  if (!item.containsKey('icon'))
                    SizedBox(height: 10,),
                  const Divider(color: Color(0xFFD9D9D9), thickness: 1),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}