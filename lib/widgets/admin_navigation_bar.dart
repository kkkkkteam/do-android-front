import 'package:flutter/material.dart';
import '../screens/admin/admin_board_screen.dart';
import '../screens/admin/admin_group_screen.dart';
import '../screens/admin/admin_main_screen.dart';

class AdminNavigationBar extends StatefulWidget {
  const AdminNavigationBar({Key? key}) : super(key: key);

  @override
  _AdminNavigationBarState createState() => _AdminNavigationBarState();
}

class _AdminNavigationBarState extends State<AdminNavigationBar> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = [
    AdminMainScreen(),
    AdminBoardScreen(),
    AdminGroupScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // 현재 선택된 화면 표시
      bottomNavigationBar: Container(
        height: 80,
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Color(0xFFD9D9D9), width: 1.5),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(icon:Icons.account_box, index: 0),
            _buildNavItem(icon: Icons.article, index: 1),
            _buildNavItem(icon: Icons.group, index: 2),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({required IconData icon, required int index}) {
    return IconButton(
      icon: Icon(
        icon,
        color: _selectedIndex == index
            ? const Color(0xFF2E9528) // 선택된 아이템 색상
            : Colors.grey, // 선택되지 않은 아이템 색상
      ),
      iconSize: 28, // 아이콘 크기
      onPressed: () => _onItemTapped(index),
    );
  }
}