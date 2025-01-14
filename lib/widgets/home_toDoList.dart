import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final String leftText; // 왼쪽 텍스트
  final String rightText; // 오른쪽 텍스트
  final List<String> contentList; // 내용 리스트
  final VoidCallback onPressed; // 아이콘 버튼 클릭 동작

  const CustomContainer({
    Key? key,
    required this.leftText,
    required this.rightText,
    required this.contentList,
    required this.onPressed, // onPressed 매개변수 추가
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              leftText,
              style: const TextStyle(
                fontSize: 18,
                fontFamily: 'Dohyeon',
              ),
            ),
            Text(
              rightText,
              style: const TextStyle(
                fontSize: 18,
                fontFamily: 'Dohyeon',
              ),
            ),
          ],
        ),
        const SizedBox(height: 8), // 상단과 컨테이너 간의 여백
        Container(
          decoration: BoxDecoration(
            color: Colors.white, // 배경 색상
            border: Border.all(color: const Color(0xFFB4B4B4), width: 1.5), // 테두리 색상과 두께
            borderRadius: BorderRadius.circular(12), // 둥근 모서리
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0), // 내부 여백
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 리스트 내용
                    ...contentList.map((content) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4), // 리스트 간의 간격 줄임
                        child: Text(
                          content,
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'Dohyeon',
                            color: Colors.black,
                          ),
                        ),
                      );
                    }).toList(),
                    // 아이콘 버튼 (컨테이너당 하나)
                  ],
                ),
                IconButton(
                  onPressed: onPressed, // 클릭 시 동작 수행
                  icon: const Icon(Icons.arrow_forward_ios),
                  iconSize: 18,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
