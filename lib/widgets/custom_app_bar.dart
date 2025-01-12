import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title; // 앱바 타이틀
  final List<Widget>? actions; // 오른쪽 아이콘들
  final Widget? leading; // 왼쪽 요소

  const CustomAppBar({
    Key? key,
    required this.title,
    this.actions,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: leading ??
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              'do.',
              style: const TextStyle(
                fontFamily: 'RubikScribble',
                fontSize: 24,
                color: Color(0xFF2E9629),
              ),
            ),
          ),
      actions: actions ??
          [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications, color: Colors.black),
            ),
          ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
