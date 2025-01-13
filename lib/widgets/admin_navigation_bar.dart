import 'package:flutter/material.dart';
import '../screens/admin/admin_main_screen.dart'; // 관리자 홈 화면
import '../screens/admin/admin_board_screen.dart'; // 게시판 화면
import '../screens/admin/admin_group_screen.dart'; // 캘린더 화면
import '../screens/admin/admin_exprience_screen.dart'; // 프로필 화면


class AdminNavigationBar extends StatefulWidget {
  const AdminNavigationBar({Key? key}) : super(key: key);

  @override
  _AdminNavigationBarState createState() => _AdminNavigationBarState();
}

class _AdminNavigationBarState extends State<AdminNavigationBar> {
  int _selectedIndex = 0;

  // 네비게이션 바에 표시될 화면 목록
  static const List<Widget> _pages = [
    AdminMainScreen(),    // 관리자 홈 화면
    AdminBoardScreen(),   // 게시판 화면
    AdminGroupScreen(), // 캘린더 화면
    AdminProfileScreen(), // 프로필 화면
  ];

  // 네비게이션 아이템 선택 시 처리
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // 현재 선택된 화면 표시
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '사내계정관리'),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: '공지사항'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: '소속 및 그룹'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '경험치'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF2E9528),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
