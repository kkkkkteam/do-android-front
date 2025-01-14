import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  const SearchTextField({
    required this.hintText,
    this.controller,
    this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      style: const TextStyle(
        fontSize: 15,
        fontFamily: 'Roboto1',
        color: Colors.black, // 텍스트 색상 설정
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          fontSize: 15,
          fontFamily: 'Roboto1',
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
    );
  }
}
