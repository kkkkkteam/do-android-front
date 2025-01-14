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
  late String selectedJobGroup;

  // 직무 그룹 리스트
  final List<String> jobGroups = [
    '물구나무서기 선생님',
    '코딩 마스터',
    '디자인 전문가',
    '프로젝트 매니저',
    'HR 관리자',
  ];

@override
void initState() {
  super.initState();
  nameController = TextEditingController(text: widget.auth.name);
  idController = TextEditingController(text: widget.auth.id);
  departmentController = TextEditingController(text: widget.auth.department);
  joinDateController = TextEditingController(text: widget.auth.joinDate);

  // Ensure selectedJobGroup is valid and in the jobGroups list
  selectedJobGroup = widget.auth.jobGroup;
  if (!jobGroups.contains(selectedJobGroup)) {
    selectedJobGroup = jobGroups.first; // Default to the first item if invalid
  }
}

  Future<void> _selectJoinDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.parse(widget.auth.joinDate.replaceAll('.', '-')), // 초기 값
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        joinDateController.text = "${pickedDate.year}.${pickedDate.month.toString().padLeft(2, '0')}.${pickedDate.day.toString().padLeft(2, '0')}";
      });
    }
  }

  void _saveChanges() {
  Navigator.pop(
    context,
    Auth(
      name: nameController.text,
      id: idController.text,
      department: departmentController.text,
      joinDate: joinDateController.text,
      jobGroup: selectedJobGroup,
      yearlyExperience: widget.auth.yearlyExperience,
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          '사원 정보 수정',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    AuthProfileImageEditor(),
                    SizedBox(height: 8),
                    Text(
                      '사진 수정',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              _buildEditableRow('이름', nameController),
              _buildEditableRow('사번', idController),
              _buildEditableRow('소속', departmentController),
              _buildEditableRowWithDatePicker('입사일', joinDateController, _selectJoinDate),
              _buildEditableDropdown('직무그룹', jobGroups, selectedJobGroup),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _saveChanges,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    '저장하기',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEditableRow(String label, TextEditingController controller) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0), // 간격 좁게 설정
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    controller.text,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.end,
                  ),
                  SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      _editField(controller, label);
                    },
                    child: Icon(
                      Icons.edit,
                      size: 18,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 1), // Divider 위 간격 좁게 설정
      Divider(color: Colors.grey.shade300),
      const SizedBox(height: 1), // Divider 아래 간격 좁게 설정
    ],
  );
}

Widget _buildEditableRowWithDatePicker(
    String label, TextEditingController controller, Function onTap) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0), // 간격 더 줄임
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => onTap(),
                child: AbsorbPointer(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.calendar_today, size: 18),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 12, // 상하 간격 줄이기
                      ),
                    ),
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0), // Divider 위아래 간격 줄임
        child: Divider(
          color: Colors.grey.shade300,
          thickness: 1,
          height: 1, // 추가 높이 제거
        ),
      ),
    ],
  );
}



  Widget _buildEditableDropdown(String label, List<String> items, String selectedValue) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
            SizedBox(
              width: 160, // 드롭다운 크기 제한 (필요 시 조정 가능)
              child: DropdownButton<String>(
                value: selectedValue,
                icon: Icon(Icons.arrow_drop_down),
                isExpanded: true,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedJobGroup = newValue!;
                  });
                },
                items: items.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
      Divider(color: Colors.grey.shade300),
    ],
  );
}





  void _editField(TextEditingController controller, String label) {
    showDialog(
      context: context,
      builder: (context) {
        final tempController = TextEditingController(text: controller.text);
        return AlertDialog(
          title: Text(label),
          content: TextField(
            controller: tempController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: '수정할 내용을 입력해주세요',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('취소'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  controller.text = tempController.text;
                });
                Navigator.pop(context);
              },
              child: Text('수정'),
            ),
          ],
        );
      },
    );
  }
}