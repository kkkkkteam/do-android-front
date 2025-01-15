import 'package:flutter/material.dart';
import 'edit_profile_screen.dart';
import '../../widgets/custom_progress_bar.dart';
import '../../widgets/custom_section.dart';
import 'password_change_screen.dart';
import '../../widgets/custom_button.dart';
import 'experience_list_screen.dart';
import 'yearly_experience_screen.dart';
import '../../screens/login_choice_screen.dart';
import '../../utils/token_storage.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String profileImage = 'assets/images/man-01.png';
  Future<void> _logout() async {
    final tokenStorage = TokenStorage();
    await tokenStorage.clearTokens(); // 저장된 모든 토큰 제거
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginChoiceScreen()),
    );
  }

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
                                fontFamily: 'Dohyeon',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              '김민수', // 사용자 이름
                              style: TextStyle(
                                fontSize: 25,
                                fontFamily: 'Dohyeon',
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
                      CustomButton(
                        text: '프로필 사진 변경',
                        onPressed: () async {
                          final selectedImage = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EditProfileScreen(),
                            ),
                          );
                          if (selectedImage != null && selectedImage is String) {
                            setState(() {
                              profileImage = selectedImage; // 선택된 이미지 업데이트
                            });
                          }
                        },
                        color: const Color(0xFF2E9629),
                      ),
                      const SizedBox(height: 40),
                      CustomSection(
                        title: '정보',
                        initialItems: [
                          {'title': '사번', 'value': '2023010101'},
                          {'title': '소속', 'value': '음성 1센터'},
                          {'title': '입사일', 'value': '2023-01-01'},
                          {'title': '직무그룹', 'value': '1'},
                        ],
                      ),
                      const SizedBox(height: 30),
                      CustomSection(
                        title: '계정',
                        initialItems: [
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
                          {
                            'title': '로그아웃',
                            'value': '',
                            'icon': const Icon(Icons.chevron_right),
                            'onPressed': () {
                              _logout();
                            },
                          },
                        ],
                      ),
                      const SizedBox(height: 30),
                      CustomSection(
                        title: '경험치',
                        initialItems: [
                          {'title': '최근 획득한 경험치', 'value': '5000 do'},
                          {
                            'title': '경험치 내역 확인',
                            'value': '보기',
                            'icon': const Icon(Icons.chevron_right),
                            'onPressed': () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ExperienceListScreen(),
                                ),
                              );
                            },
                          },
                          {
                            'title': '연도별 경험치',
                            'value': '보기',
                            'icon': const Icon(Icons.chevron_right),
                            'onPressed': () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const YearlyExperienceScreen(),
                                ),
                              );
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
            Positioned(
              top: 130,
              child: CircleAvatar(
                radius: 70,
                backgroundColor: const Color(0xFF2E9629), // 초록색 테두리
                child: CircleAvatar(
                  radius: 67,
                  backgroundColor: const Color(0xFFF9F9F9),
                  backgroundImage: AssetImage(profileImage), // 선택된 프로필 이미지 적용
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
