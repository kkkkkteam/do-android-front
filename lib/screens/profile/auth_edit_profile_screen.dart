import 'package:flutter/material.dart';
import '../models/auth.dart';
import '../../widgets/auth_profile_image_editor.dart';


class AuthEditProfileScreen extends StatefulWidget {
  final Auth auth;

  AuthEditProfileScreen({required this.auth});

  @override
  _AuthEditProfileScreenState createState() => _AuthEditProfileScreenState();
}

class _AuthEditProfileScreenState extends State<AuthEditProfileScreen> {
  late TextEditingController nameController;
  late TextEditingController idController;
  late TextEditingController departmentController;
  late TextEditingController joinDateController;
  late TextEditingController jobGroupController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.auth.name);
    idController = TextEditingController(text: widget.auth.id);
    departmentController = TextEditingController(text: widget.auth.department);
    joinDateController = TextEditingController(text: widget.auth.joinDate);
    jobGroupController = TextEditingController(text: widget.auth.jobGroup);
  }

  void _saveChanges() {
    Navigator.pop(
      context,
      Auth(
        name: nameController.text,
        id: idController.text,
        department: departmentController.text,
        joinDate: joinDateController.text,
        jobGroup: jobGroupController.text,
        yearlyExperience: widget.auth.yearlyExperience,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('사원 정보 수정')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            AuthProfileImageEditor(),
            TextField(controller: nameController, decoration: InputDecoration(labelText: '이름')),
            TextField(controller: idController, decoration: InputDecoration(labelText: '아이디')),
            TextField(controller: departmentController, decoration: InputDecoration(labelText: '소속')),
            TextField(controller: joinDateController, decoration: InputDecoration(labelText: '입사일')),
            TextField(controller: jobGroupController, decoration: InputDecoration(labelText: '직무그룹')),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _saveChanges, child: Text('저장하기')),
          ],
        ),
      ),
    );
  }
}
