import 'package:flutter/material.dart';

class BoardUploadAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const BoardUploadAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () {
          Navigator.pop(context); // 이전 화면으로 돌아가기
        },
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontFamily: 'NanumGothic',
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
