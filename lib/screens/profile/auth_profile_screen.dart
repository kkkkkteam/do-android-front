import 'package:flutter/material.dart';
import 'package:do_frontend/screens/models/auth.dart';
import 'auth_edit_profile_screen.dart';
import '../../widgets/auth_profile_image_editor.dart';
import '../../widgets/auth_info_row.dart';

class AuthProfileScreen extends StatefulWidget {
  final Auth auth; // Auth 객체를 받을 수 있도록 필드 추가

  const AuthProfileScreen({required this.auth, Key? key}) : super(key: key); // 생성자 추가

  @override
  _AuthProfileScreenState createState() => _AuthProfileScreenState();
}

class _AuthProfileScreenState extends State<AuthProfileScreen> {
  late Auth auth;

  @override
  void initState() {
    super.initState();
    auth = widget.auth; // 전달받은 Auth 객체 저장
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
          title: Text('do.'),
          centerTitle: true,
          bottom: TabBar(
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
          AuthProfileImageEditor(),
          SizedBox(height: 20),
          Text('사원이름', style: TextStyle(fontSize: 14, fontFamily: 'Jua')),
          Text(auth.name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Divider(),
          AuthInfoRow(title: '아이디', value: auth.id),
          AuthInfoRow(title: '소속', value: auth.department),
          AuthInfoRow(title: '입사일', value: auth.joinDate),
          AuthInfoRow(title: '직무그룹', value: auth.jobGroup),
          Divider(),
          Text('경험치', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          AuthInfoRow(title: '총 경험치', value: '${auth.totalExperience}'),
          ...auth.yearlyExperience.entries.map((entry) {
            return AuthInfoRow(title: entry.key, value: '${entry.value}');
          }),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              final updatedAuth = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AuthEditProfileScreen(auth: auth)),
              );
              if (updatedAuth != null) {
                _updateAuth(updatedAuth);
              }
            },
            child: Text('사원 정보 수정'),
          ),
        ],
      ),
    );
  }
}
