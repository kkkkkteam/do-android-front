import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget {
  final List<Map<String, dynamic>> items;

  const CustomNavigationBar({required this.items, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFD9D9D9), width: 1.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.map((item) {
          return IconButton(icon: Icon(item['icon']), onPressed: item['onPressed']);
        }).toList(),
      ),
    );
  }
}
