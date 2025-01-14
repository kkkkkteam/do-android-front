import 'package:flutter/material.dart';
import '../../models/auth.dart';
import 'admin_edit_profile_screen.dart';

class AuthProfileScreen extends StatefulWidget {
  final Auth auth;

  const AuthProfileScreen({required this.auth, Key? key}) : super(key: key);

  @override
  _AuthProfileScreenState createState() => _AuthProfileScreenState();
}

class _AuthProfileScreenState extends State<AuthProfileScreen> {
  late Auth auth;

  // 직무 그룹별 경험치 테이블
  final Map<String, List<int>> experienceTable = {
    "F": [
      0,
      13500,
      27000,
      39000,
      51000,
      63000,
      78000,
      93000,
      108000,
      126000,
      144000,
      162000
    ],
    "B": [0, 24000, 52000, 78000, 117000, 169000],
    "G": [0, 24000, 52000, 78000, 117000, 169000],
    "T": [0, 24000, 52000, 78000, 117000, 169000],
  };

  // 연도별 경험치 데이터 (예시 데이터)
  final Map<int, int> yearlyExperience = {
    2021: 15000,
    2022: 20000,
    2023: 15000,
  };

  @override
  void initState() {
    super.initState();
    auth = widget.auth;
  }

  void _updateAuth(Auth updatedAuth) {
    setState(() {
      auth = updatedAuth;
    });
  }

  // 경험치 기반 레벨 계산
  Map<String, dynamic> _calculateLevel(String jobGroup, int totalExperience) {
    final levels = experienceTable[jobGroup] ?? [];
    for (int i = levels.length - 1; i >= 0; i--) {
      if (totalExperience >= levels[i]) {
        int levelNumber = i + 1;
        String? suffix;
        if (jobGroup == "F") {
          suffix = _romanNumeral((i % 3) + 1); // 접미사는 Ⅰ, Ⅱ, Ⅲ
          levelNumber = (i ~/ 3) + 1; // 숫자 레벨 계산 (1, 2, 3...)
        }
        return {
          "level": "$jobGroup$levelNumber${suffix != null ? '-$suffix' : ''}",
          "nextLevelExperience": (i + 1 < levels.length ? levels[i + 1] : null)
        };
      }
    }
    return {
      "level": "$jobGroup${levels.length}",
      "nextLevelExperience": levels.isNotEmpty ? levels[0] : null,
    };
  }

  @override
  Widget build(BuildContext context) {
    final totalExperience = yearlyExperience.values.reduce((a, b) => a + b);
    final jobGroup = auth.jobGroup.substring(0, 1); // 직무 그룹의 첫 글자 (F, B, G, T)
    final levelInfo = _calculateLevel(jobGroup, totalExperience);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            'do.',
            style: TextStyle(
              fontFamily: 'RubikScribble',
              fontSize: 30,
              color: Color(0xFF2E9629),
            ),
          ),
          centerTitle: true,
          actions: [
            GestureDetector(
              onTap: () async {
                final updatedAuth = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AuthEditProfileScreen(auth: auth),
                  ),
                );
                if (updatedAuth != null) {
                  _updateAuth(updatedAuth);
                }
              },
              child: const Padding(
                padding: EdgeInsets.only(right: 16.0),
                child: Center(
                  child: Text(
                    '사원 정보 수정',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'NanumGothic',
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ],
          bottom: const TabBar(
            indicatorColor: Colors.green,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: '정보'),
              Tab(text: '달력'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildProfileInfo(levelInfo, totalExperience),
            const Center(child: Text('달력 탭')),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileInfo(Map<String, dynamic> levelInfo, int totalExperience) {
    final jobGroup = auth.jobGroup.substring(0, 1); // 직군의 첫 글자 추출 (F, B, G, T)

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '사원이름',
                      style: TextStyle(fontSize: 14, fontFamily: 'NanumGothic'),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      auth.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 80,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage(auth.profileImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            "정보",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const Divider(color: Colors.green, thickness: 2),
          _buildInfoRow("사번", auth.id),
          _buildInfoRow("소속", auth.department),
          _buildInfoRow("입사일", auth.joinDate),
          _buildInfoRow("직군", auth.jobGroup),
          const SizedBox(height: 20),
          const Text(
            "연도별 경험치",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const Divider(color: Colors.green, thickness: 2),
          ...yearlyExperience.entries
              .map((entry) =>
              _buildInfoRow("${entry.key}년", "${entry.value} do"))
              .toList(),
          const SizedBox(height: 20),
          const Text(
            "레벨 및 총 경험치",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const Divider(color: Colors.green, thickness: 2),
          _buildInfoRow("현재 레벨", "${levelInfo['level']}"),
          _buildInfoRow("총 획득 경험치", "$totalExperience do"),
          if (levelInfo["nextLevelExperience"] != null)
            _buildInfoRow(
              "다음 레벨까지",
              "${levelInfo['nextLevelExperience'] - totalExperience} do",
            ),
        ],
      ),
    );
  }

  String _romanNumeral(int value) {
    switch (value) {
      case 1:
        return "Ⅰ";
      case 2:
        return "Ⅱ";
      case 3:
        return "Ⅲ";
      default:
        return "";
    }
  }

  Widget _buildInfoRow(String title, String value) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'NanumGothic',
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'NanumGothic',
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        const Divider(color: Colors.grey, thickness: 1),
      ],
    );
  }
}
