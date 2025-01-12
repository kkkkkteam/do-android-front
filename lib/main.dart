import 'package:flutter/material.dart';
import 'screens/home/home_screen.dart';
import 'screens/notification/notification_screen.dart';
import 'screens/calendar/calendar_screen.dart';
import 'screens/profile/profile_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Navigation App',
      theme: ThemeData(
        primaryColor: const Color(0xFF2E9528),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white, // 네비게이션 바 배경 흰색
          selectedItemColor: Color(0xFF2E9528), // 선택된 아이콘 색상
          unselectedItemColor: Colors.grey, // 선택되지 않은 아이콘 색상
          selectedIconTheme: IconThemeData(size: 28), // 아이콘 크기 고정
          unselectedIconTheme: IconThemeData(size: 28), // 아이콘 크기 고정
        ),
      ),
      home: const NavigationHome(),
    );
  }
}

class NavigationHome extends StatefulWidget {
  const NavigationHome({Key? key}) : super(key: key);

  @override
  State<NavigationHome> createState() => _NavigationHomeState();
}

class _NavigationHomeState extends State<NavigationHome> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const NotificationScreen(),
    const CalendarScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min, // 네비게이션 바 높이에 영향을 미치지 않음
        children: [
          Container(
            height: 1.5, // 회색 구분선 높이
            color: const Color(0xFFD9D9D9), // 회색 절취선 색상
          ),
          BottomNavigationBar(
            type: BottomNavigationBarType.fixed, // 아이콘 및 위치 고정
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            showSelectedLabels: false, // 선택된 라벨 숨김
            showUnselectedLabels: false, // 선택되지 않은 라벨 숨김
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: '', // 빈 라벨
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: '', // 빈 라벨
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today),
                label: '', // 빈 라벨
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: '', // 빈 라벨
              ),
            ],
          ),
        ],
      ),
    );
  }
}
