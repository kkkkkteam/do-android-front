import 'package:flutter/material.dart';

class AdminExperienceScreen extends StatefulWidget {
  const AdminExperienceScreen({Key? key}) : super(key: key);

  @override
  State<AdminExperienceScreen> createState() => _AdminExperienceScreenState();
}

class _AdminExperienceScreenState extends State<AdminExperienceScreen> {
  final List<String> categories = [
    '인사평가',
    '직무 퀘스트',
    '리더부여 퀘스트',
    '전사 프로젝트',
  ];

  // 데이터를 관리할 Map
  final Map<String, dynamic> experienceData = {
    '인사평가': [],
    '직무 퀘스트': [],
    '리더부여 퀘스트': [],
    '전사 프로젝트': [],
  };

  void _showCategoryDialog(String category) {
    switch (category) {
      case '인사평가':
        _showHRDialog();
        break;
      case '직무 퀘스트':
        _showTaskQuestDialog();
        break;
      case '리더부여 퀘스트':
        _showLeaderQuestDialog();
        break;
      case '전사 프로젝트':
        _showProjectDialog();
        break;
    }
  }

  // **인사평가 다이얼로그**
  void _showHRDialog() {
    String period = "상반기";
    String employee = "";
    String grade = "";
    String experience = "";

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('인사평가 경험치 부여'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField(
                value: period,
                items: const [
                  DropdownMenuItem(value: "상반기", child: Text("상반기")),
                  DropdownMenuItem(value: "하반기", child: Text("하반기")),
                ],
                onChanged: (value) => period = value!,
                decoration: const InputDecoration(labelText: "평가 기간"),
              ),
              TextField(
                onChanged: (value) => employee = value,
                decoration: const InputDecoration(labelText: "직원 이름"),
              ),
              TextField(
                onChanged: (value) => grade = value,
                decoration: const InputDecoration(labelText: "평가 등급"),
              ),
              TextField(
                onChanged: (value) => experience = value,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "부여 경험치"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('취소'),
            ),
            ElevatedButton(
              onPressed: () {
                if (employee.isNotEmpty && grade.isNotEmpty && experience.isNotEmpty) {
                  setState(() {
                    experienceData['인사평가'].add({
                      'period': period,
                      'employee': employee,
                      'grade': grade,
                      'experience': int.tryParse(experience),
                    });
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('추가'),
            ),
          ],
        );
      },
    );
  }

  // **직무 퀘스트 다이얼로그**
  void _showTaskQuestDialog() {
    String team = "";
    String group = "";
    String quest = "";
    String cycle = "주별";
    String experience = "";

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('직무 퀘스트 추가'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) => team = value,
                decoration: const InputDecoration(labelText: "소속"),
              ),
              TextField(
                onChanged: (value) => group = value,
                decoration: const InputDecoration(labelText: "직무 그룹"),
              ),
              TextField(
                onChanged: (value) => quest = value,
                decoration: const InputDecoration(labelText: "퀘스트 이름"),
              ),
              DropdownButtonFormField(
                value: cycle,
                items: const [
                  DropdownMenuItem(value: "주별", child: Text("주별")),
                  DropdownMenuItem(value: "월별", child: Text("월별")),
                ],
                onChanged: (value) => cycle = value!,
                decoration: const InputDecoration(labelText: "부여 주기"),
              ),
              TextField(
                onChanged: (value) => experience = value,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "경험치"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('취소'),
            ),
            ElevatedButton(
              onPressed: () {
                if (team.isNotEmpty && group.isNotEmpty && quest.isNotEmpty && experience.isNotEmpty) {
                  setState(() {
                    experienceData['직무 퀘스트'].add({
                      'team': team,
                      'group': group,
                      'quest': quest,
                      'cycle': cycle,
                      'experience': int.tryParse(experience),
                    });
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('추가'),
            ),
          ],
        );
      },
    );
  }

  // **리더부여 퀘스트 다이얼로그**
  void _showLeaderQuestDialog() {
    String leader = "";
    String quest = "";
    String cycle = "주별";
    String maxCondition = "";

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('리더부여 퀘스트 추가'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) => leader = value,
                decoration: const InputDecoration(labelText: "리더 이름"),
              ),
              TextField(
                onChanged: (value) => quest = value,
                decoration: const InputDecoration(labelText: "퀘스트 이름"),
              ),
              DropdownButtonFormField(
                value: cycle,
                items: const [
                  DropdownMenuItem(value: "주별", child: Text("주별")),
                  DropdownMenuItem(value: "월별", child: Text("월별")),
                ],
                onChanged: (value) => cycle = value!,
                decoration: const InputDecoration(labelText: "부여 주기"),
              ),
              TextField(
                onChanged: (value) => maxCondition = value,
                decoration: const InputDecoration(labelText: "Max 조건"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('취소'),
            ),
            ElevatedButton(
              onPressed: () {
                if (leader.isNotEmpty && quest.isNotEmpty && maxCondition.isNotEmpty) {
                  setState(() {
                    experienceData['리더부여 퀘스트'].add({
                      'leader': leader,
                      'quest': quest,
                      'cycle': cycle,
                      'maxCondition': maxCondition,
                    });
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('추가'),
            ),
          ],
        );
      },
    );
  }

  // **전사 프로젝트 다이얼로그**
  void _showProjectDialog() {
    String project = "";
    String participant = "";
    String experience = "";

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('전사 프로젝트 추가'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) => project = value,
                decoration: const InputDecoration(labelText: "프로젝트 이름"),
              ),
              TextField(
                onChanged: (value) => participant = value,
                decoration: const InputDecoration(labelText: "참여자"),
              ),
              TextField(
                onChanged: (value) => experience = value,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "경험치"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('취소'),
            ),
            ElevatedButton(
              onPressed: () {
                if (project.isNotEmpty && participant.isNotEmpty && experience.isNotEmpty) {
                  setState(() {
                    experienceData['전사 프로젝트'].add({
                      'project': project,
                      'participant': participant,
                      'experience': int.tryParse(experience),
                    });
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('추가'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('경험치 및 퀘스트 관리')),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return ListTile(
            title: Text(category),
            trailing: ElevatedButton(
              onPressed: () => _showCategoryDialog(category),
              child: const Text('관리'),
            ),
          );
        },
      ),
    );
  }
}
