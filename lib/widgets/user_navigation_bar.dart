import 'package:flutter/material.dart';
import '../screens/home/home_screen.dart';
import '../screens/board/board_screen.dart';
import '../screens/calendar/calendar_screen.dart';
import '../screens/profile/profile_screen.dart';

class UserNavigationBar extends StatefulWidget {
  final int initialIndex; // 초기 화면 인덱스

  const UserNavigationBar({Key? key, this.initialIndex = 0}) : super(key: key);

  @override
  _UserNavigationBarState createState() => _UserNavigationBarState();
}

class _UserNavigationBarState extends State<UserNavigationBar> {
  late int _selectedIndex;
  Map<DateTime, List<Map<String, dynamic>>> _events = {}; // 일정 저장

  static List<Widget> _pages(
      Map<DateTime, List<Map<String, dynamic>>> events,
      void Function(Map<DateTime, List<Map<String, dynamic>>>) onEventsChanged,
      ) => [
    const HomeScreen(),
    const BoardScreen(),
    CalendarScreen(
      events: events,
      onEventsChanged: onEventsChanged,
    ),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex; // 초기 인덱스 설정
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _updateEvents(Map<DateTime, List<Map<String, dynamic>>> newEvents) {
    setState(() {
      _events = newEvents; // 새로운 이벤트 데이터로 업데이트
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages(_events, _updateEvents)[_selectedIndex], // 현재 선택된 화면 표시
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
            _buildNavItem(icon: Icons.home, index: 0),
            _buildNavItem(icon: Icons.chat, index: 1),
            _buildNavItem(icon: Icons.calendar_today, index: 2),
            _buildNavItem(icon: Icons.person, index: 3),
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
            ? const Color(0xFF2E9529) // 선택된 아이템 색상
            : Colors.grey, // 선택되지 않은 아이템 색상
      ),
      iconSize: 28, // 아이콘 크기
      onPressed: () => _onItemTapped(index),
    );
  }
}
