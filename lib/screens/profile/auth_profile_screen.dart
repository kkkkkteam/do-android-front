import 'package:flutter/material.dart';
import 'package:do_frontend/screens/models/auth.dart';
import 'auth_edit_profile_screen.dart';
import '../../widgets/auth_profile_image_editor.dart';
import '../../widgets/auth_info_row.dart';

class AuthProfileScreen extends StatefulWidget {
  final Auth auth;

  const AuthProfileScreen({required this.auth, Key? key}) : super(key: key);

  @override
  _AuthProfileScreenState createState() => _AuthProfileScreenState();
}

class _AuthProfileScreenState extends State<AuthProfileScreen> {
  late Auth auth;

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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
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
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0),
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
          bottom: TabBar(
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
            _buildProfileInfo(),
            Center(child: Text('달력 탭')),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileInfo() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
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
                    Text(
                      '사원이름',
                      style: TextStyle(fontSize: 14, fontFamily: 'NanumGothic'),
                    ),
                    SizedBox(height: 8),
                    Text(
                      auth.name,
                      style: TextStyle(
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
                    image: AssetImage('assets/profile_image.jpeg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Text(
            "정보",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Divider(color: Colors.green, thickness: 2),
          _buildInfoRow("아이디", auth.id),
          _buildInfoRow("소속", auth.department),
          _buildInfoRow("입사일", auth.joinDate),
          _buildInfoRow("직무그룹", auth.jobGroup),
          SizedBox(height: 20),
          Text(
            "경험치",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Divider(color: Colors.green, thickness: 2),
          _buildInfoRow("총 경험치", "${auth.totalExperience}"),
          ...auth.yearlyExperience.entries.map((entry) {
            return _buildInfoRow(entry.key, "${entry.value}");
          }).toList(),
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
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'NanumGothic',
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'NanumGothic',
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        Divider(color: Colors.grey, thickness: 1),
      ],
    );
  }
}
