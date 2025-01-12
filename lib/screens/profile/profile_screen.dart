import 'package:flutter/material.dart';
import 'edit_profile_screen.dart';
import '../../widgets/custom_progress_bar.dart'; // 수정된 ProgressBar
import '../../widgets/custom_section.dart'; // 수정된 Section
import 'password_change_screen.dart'; // 비밀번호 변경 화면

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                // 상단 초록색 배경
                Container(
                  height: 200,
                  color: const Color(0xFF2E9629),
                ),
                // 하단 흰색 배경
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 130, // 프로필 이미지 위치 확보
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            Text(
                              'Lv.F1-I', // 사용자 레벨
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Jua',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              '김민수', // 사용자 이름
                              style: TextStyle(
                                fontSize: 25,
                                fontFamily: 'Jua',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      const CustomProgressBar(
                        currentValue: 5000, // 현재 경험치
                        maxValue: 50000, // 최대 경험치
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const EditProfileScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2E9629),
                          minimumSize: const Size(400, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          "프로필 사진 변경",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Arial',
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      CustomSection(
                        title: '정보',
                        items: [
                          {'title': '사번', 'value': '2023010101'},
                          {'title': '소속', 'value': '음성 1센터'},
                          {'title': '입사일', 'value': '2023-01-01'},
                          {'title': '직무그룹', 'value': '1'},
                        ],
                      ),
                      const SizedBox(height: 30),
                      CustomSection(
                        title: '계정',
                        items: [
                          {'title': '아이디', 'value': 'minsukim'},
                          {
                            'title': '비밀번호',
                            'value': '변경하기',
                            'icon': const Icon(Icons.chevron_right),
                            'onPressed': () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const PasswordChangeScreen()),
                              );
                            },
                          },
                        ],
                      ),
                      const SizedBox(height: 30),
                      CustomSection(
                        title: '경험치',
                        items: [
                          {'title': '최근 획득한 경험치', 'value': '5000 do'},
                          {
                            'title': '경험치 내역 확인',
                            'value': '보기',
                            'icon': const Icon(Icons.chevron_right),
                            'onPressed': () {
                              // 특정 동작
                              print('경험치 내역 확인');
                            },
                          },
                          {
                            'title': '연도별 경험치',
                            'value': '보기',
                            'icon': const Icon(Icons.chevron_right),
                            'onPressed': () {
                              // 특정 동작
                              print('연도별 경험치 보기');
                            },
                          },
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // 중앙에 프로필 이미지
            const Positioned(
              top: 130,
              child: CircleAvatar(
                radius: 70,
                backgroundColor: Color(0xFF2E9629), // 초록색 테두리
                child: CircleAvatar(
                  radius: 67,
                  backgroundColor: Color(0xFFF9F9F9),
                  backgroundImage: AssetImage('assets/man-01.png'), // 프로필 이미지
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
