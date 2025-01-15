import 'package:flutter/material.dart';

class AdminGroupScreen extends StatefulWidget {
  const AdminGroupScreen({Key? key}) : super(key: key);

  @override
  State<AdminGroupScreen> createState() => _AdminGroupScreenState();
}

class _AdminGroupScreenState extends State<AdminGroupScreen> {
  final List<Map<String, dynamic>> affiliations = [
    {"center": "음성 1센터", "groups": ["그룹 1", "그룹 2"]},
    {"center": "음성 2센터", "groups": ["그룹 1", "그룹 2"]},
    {"center": "용인백암센터", "groups": []},
    {"center": "남양주센터", "groups": []},
    {"center": "파주센터", "groups": []},
  ];

  final List<Map<String, String>> jobPositions = [
    {"code": "F", "name": "현장 직군"},
    {"code": "B", "name": "관리 직군"},
    {"code": "G", "name": "성장 전략"},
    {"code": "T", "name": "기술 직군"},
  ];

  void addAffiliation() {
    String newAffiliation = "";
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("소속 추가하기", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                TextField(
                  onChanged: (value) => newAffiliation = value,
                  decoration: InputDecoration(
                    hintText: "소속명을 입력하세요",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: () => Navigator.pop(context), child: const Text("취소")),
                    ElevatedButton(
                      onPressed: () {
                        if (newAffiliation.isNotEmpty) {
                          setState(() {
                            affiliations.add({"center": newAffiliation, "groups": []});
                          });
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                      child: const Text("추가"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void addGroup(Map<String, dynamic> affiliation) {
    String newGroup = "";
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("그룹 추가하기", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                TextField(
                  onChanged: (value) => newGroup = value,
                  decoration: InputDecoration(
                    hintText: "그룹명을 입력하세요",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("취소"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (newGroup.isNotEmpty) {
                          setState(() {
                            affiliation["groups"].add(newGroup);
                          });
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                      child: const Text("추가"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void addJobPosition() {
    String newCode = "";
    String newName = "";
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("직군 추가하기", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                TextField(
                  onChanged: (value) => newCode = value,
                  decoration: InputDecoration(
                    hintText: "코드를 입력하세요",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  onChanged: (value) => newName = value,
                  decoration: InputDecoration(
                    hintText: "직군명을 입력하세요",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: () => Navigator.pop(context), child: const Text("취소")),
                    ElevatedButton(
                      onPressed: () {
                        if (newCode.isNotEmpty && newName.isNotEmpty) {
                          setState(() {
                            jobPositions.add({"code": newCode, "name": newName});
                          });
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                      child: const Text("추가"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showDeleteGroupDialog(Map<String, dynamic> affiliation) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "그룹 삭제",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                if (affiliation["groups"].isEmpty)
                  const Text("삭제할 그룹이 없습니다.", style: TextStyle(color: Colors.grey)),
                ...affiliation["groups"].map<Widget>((group) {
                  return ListTile(
                    title: Text(group),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          affiliation["groups"].remove(group);
                        });
                        Navigator.pop(context);
                      },
                    ),
                  );
                }).toList(),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("닫기"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void deleteJobPosition(Map<String, String> position) {
    setState(() {
      jobPositions.remove(position);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false, // 뒤로가기 버튼 제거
        title: const Text(
          'do.',
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontFamily: 'RubikScribble', fontSize: 30),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text("소속", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ...affiliations.map((affiliation) {
              return Card(
                child: ListTile(
                  trailing: PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == "deleteGroups") {
                        showDeleteGroupDialog(affiliation);
                      } else if (value == "deleteAffiliation") {
                        setState(() => affiliations.remove(affiliation));
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(value: "deleteGroups", child: Text("그룹 삭제")),
                      const PopupMenuItem(value: "deleteAffiliation", child: Text("소속 삭제")),
                    ],
                    child: const Icon(Icons.more_vert),
                  ),
                  title: Text(affiliation["center"], style: const TextStyle(fontSize: 16)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...affiliation["groups"].map<Widget>((group) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text("- $group"),
                        );
                      }).toList(),
                      TextButton(
                        onPressed: () {
                          addGroup(affiliation);
                        },
                        child: const Text("+ 그룹 추가"),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
            ElevatedButton(
              onPressed: addAffiliation,
              child: const Text("소속 추가"),
            ),
            const Divider(thickness: 2, height: 30),
            const Text("직군", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Card(
              elevation: 2,
              child: Table(
                border: TableBorder.all(color: Colors.grey.shade300),
                columnWidths: const {
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(3),
                  2: FlexColumnWidth(1),
                },
                children: [
                  TableRow(
                    decoration: BoxDecoration(color: Colors.grey.shade200),
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("코드", style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("직군명", style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                      ),
                      SizedBox(),
                    ],
                  ),
                  ...jobPositions.map((position) {
                    return TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(position["code"] ?? "", textAlign: TextAlign.center),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(position["name"] ?? "", textAlign: TextAlign.center),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: PopupMenuButton<String>(
                              onSelected: (value) {
                                if (value == "delete") {
                                  deleteJobPosition(position);
                                }
                              },
                              itemBuilder: (context) => [
                                const PopupMenuItem(value: "delete", child: Text("삭제")),
                              ],
                              child: const Icon(Icons.more_vert),
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: addJobPosition,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text("직군 추가"),
            ),
          ],
        ),
      ),
    );
  }
}