import 'package:flutter/material.dart';
import '../../models/admin/auth.dart';
import 'admin_edit_profile_screen.dart';

class AuthProfileScreen extends StatefulWidget {
  final Auth auth;

  const AuthProfileScreen({required this.auth, Key? key}) : super(key: key);

  @override
  _AuthProfileScreenState createState() => _AuthProfileScreenState();
}

class _AuthProfileScreenState extends State<AuthProfileScreen> {
  late Auth auth;

  final Map<String, List<int>> experienceTable = {
    "F": [0, 13500, 27000, 39000, 51000, 63000, 78000, 93000, 108000],
    "B": [0, 24000, 52000, 78000, 117000, 169000],
    "G": [0, 24000, 52000, 78000, 117000, 169000],
    "T": [0, 24000, 52000, 78000, 117000, 169000],
  };

  @override
  void initState() {
    super.initState();
    auth = widget.auth;
  }

  /// 경험치와 직군을 기반으로 레벨 계산
  Map<String, dynamic> _calculateLevel(String jobGroup, int totalExperience) {
    final levels = experienceTable[jobGroup] ?? [];
    for (int i = levels.length - 1; i >= 0; i--) {
      if (totalExperience >= levels[i]) {
        return {
          "level": "$jobGroup${i + 1}",
          "nextLevelExperience": (i + 1 < levels.length) ? levels[i + 1] : null,
        };
      }
    }
    return {"level": "$jobGroup${levels.length}", "nextLevelExperience": null};
  }

  /// 레벨의 접미사를 로마 숫자로 변환
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

  @override
  Widget build(BuildContext context) {
    final totalExperience = auth.yearlyExperience.values.fold(0, (a, b) => a + b);
    final jobGroup = auth.jobGroup.substring(0, 1); // 직군의 첫 글자 추출
    final levelInfo = _calculateLevel(jobGroup, totalExperience);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context, auth), // 수정된 데이터를 반환
        ),
        title: const Text(
          'do.',
          style: TextStyle(
            fontFamily: 'RubikScribble',
            fontSize: 30,
            fontWeight: FontWeight.bold,
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
              if (updatedAuth != null && updatedAuth is Auth) {
                setState(() {
                  auth = updatedAuth;
                });
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _buildProfileInfo(levelInfo, totalExperience),
      ),
    );
  }

  Widget _buildProfileInfo(Map<String, dynamic> levelInfo, int totalExperience) {
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
          ...auth.yearlyExperience.entries.map(
                (entry) => _buildInfoRow("${entry.key}년", "${entry.value} do"),
          ),
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