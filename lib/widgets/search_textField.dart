import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  final String hintText; // 텍스트 필드 설명

  const SearchTextField({
    required this.hintText, // 설명 매개변수
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          fontSize: 15,
          fontFamily: 'Roboto1',
          color: Color(0xFFAAAAAA),
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: const Icon(Icons.search, color: Colors.black), // 검색 아이콘
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF2E9629)), // 초록색 테두리
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF2E9629)), // 초록색 테두리
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
