import 'package:flutter/material.dart';
import '../../models/auth.dart';
import 'admin_profile_screen.dart';

class AdminMainScreen extends StatefulWidget {
  const AdminMainScreen({Key? key}) : super(key: key);

  @override
  State<AdminMainScreen> createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> {
  List<Map<String, dynamic>> users = [
    {
      "name": "고경수",
      "id": "001",
      "team": "음성 1센터",
      "joinDate": "2023-01-10",
      "job": "F현장직군",
      "isStarred": true,
      "starOrder": 1672531200000,
      "createdOrder": 1,
      "profileImage": "assets/images/man-01.png",
    },
    {
      "name": "이동건",
      "id": "002",
      "team": "음성 2센터",
      "joinDate": "2022-05-01",
      "job": "B관리직군",
      "isStarred": true,
      "starOrder": 1672617600000,
      "createdOrder": 2,
      "profileImage": "assets/images/man-02.png",
    },
    {
      "name": "박찬",
      "id": "003",
      "team": "감자튀김센터",
      "joinDate": "2021-08-15",
      "job": "감자",
      "isStarred": false,
      "starOrder": null,
      "createdOrder": 3,
      "profileImage": "assets/images/man-03.png",
    },
    {
      "name": "장서인",
      "id": "004",
      "team": "치즈떡볶이센터",
      "joinDate": "2020-03-20",
      "job": "치즈",
      "isStarred": false,
      "starOrder": null,
      "createdOrder": 4,
      "profileImage": "assets/images/woman-05.png",
    },
  ];

  List<Map<String, dynamic>> filteredUsers = [];
  String searchQuery = ""; // 검색어
  String selectedSort = "등록순"; // 현재 선택된 정렬 방식

  @override
  void initState() {
    super.initState();
    filteredUsers = List.from(users); // 초기 필터링 리스트는 전체 리스트
    applySort(); // 초기 정렬 적용
  }

  /// 프로필 이미지 경로 가져오기
  String _getProfileImage(Map<String, dynamic> user) {
    return user["profileImage"] ?? "assets/images/default_profile.png"; // 기본 이미지
  }

  void toggleStar(int index) {
    setState(() {
      if (filteredUsers[index]["isStarred"]) {
        filteredUsers[index]["isStarred"] = false;
        filteredUsers[index]["starOrder"] = null;
      } else {
        filteredUsers[index]["isStarred"] = true;
        filteredUsers[index]["starOrder"] = DateTime.now().millisecondsSinceEpoch;
      }

      int userIndex = users.indexWhere(
              (user) => user["name"] == filteredUsers[index]["name"]);
      users[userIndex] = filteredUsers[index];

      applySort();
    });
  }

  void filterUsers(String query) {
    setState(() {
      searchQuery = query;
      filteredUsers = users.where((user) {
        return user["name"].contains(query) ||
            user["team"].contains(query) ||
            user["job"].contains(query);
      }).toList();

      applySort();
    });
  }

  void applySort() {
    if (selectedSort == "즐겨찾기순") {
      filteredUsers.sort((a, b) {
        if (a["isStarred"] && b["isStarred"]) {
          return b["starOrder"]!.compareTo(a["starOrder"]!);
        } else if (a["isStarred"]) {
          return -1;
        } else if (b["isStarred"]) {
          return 1;
        } else {
          return 0;
        }
      });
    } else {
      filteredUsers.sort((a, b) => a["createdOrder"].compareTo(b["createdOrder"]));
    }
  }

  void showAddUserDialog() {
    String name = "";
    String id = "";
    String team = "";
    String joinDate = "";
    String job = "";

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.black),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      const Spacer(),
                      const Text(
                        "신규 계정 생성",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                  const SizedBox(height: 20),

                  TextField(
                    onChanged: (value) => name = value,
                    decoration: _inputDecoration("이름"),
                  ),
                  const SizedBox(height: 15),

                  TextField(
                    onChanged: (value) => id = value,
                    decoration: _inputDecoration("사번"),
                  ),
                  const SizedBox(height: 15),

                  TextField(
                    onChanged: (value) => team = value,
                    decoration: _inputDecoration("소속"),
                  ),
                  const SizedBox(height: 15),

                  TextField(
                    onChanged: (value) => joinDate = value,
                    decoration: _inputDecoration("입사일"),
                  ),
                  const SizedBox(height: 15),

                  TextField(
                    onChanged: (value) => job = value,
                    decoration: _inputDecoration("직군 (형식: F현장직군, B관리직군 등)"),
                  ),
                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () {
                      // 직군 형식 검증
                      final validPrefixes = ['F', 'B', 'G', 'T']; // 허용되는 알파벳 접두사
                      bool isValidJob = validPrefixes.any((prefix) => job.startsWith(prefix));

                      if (name.isEmpty || id.isEmpty || team.isEmpty || joinDate.isEmpty || job.isEmpty) {
                        _showErrorDialog("모든 필드를 입력해야 합니다.");
                        return;
                      }

                      setState(() {
                        users.add({
                          "name": name,
                          "id": id,
                          "team": team,
                          "joinDate": joinDate,
                          "job": job,
                          "isStarred": false,
                          "createdOrder": users.length + 1,
                          "profileImage": "assets/images/man-01.png", // 고정된 프로필 이미지
                        });
                        filteredUsers = List.from(users);
                      });
                      applySort();
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2E9629),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text("계정 생성"),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// 경고 메시지 다이얼로그
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text("오류", style: TextStyle(color: Colors.red)),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("확인"),
            ),
          ],
        );
      },
    );
  }



  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Color(0xFF2E9629)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFF2E9629)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFF2E9629)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            pinned: true,
            elevation: 0,
            title: const Text(
              'do.',
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontFamily: 'RubikScribble',
                fontSize: 30,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    onChanged: filterUsers,
                    decoration: _inputDecoration("검색"),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '총 ${users.length}명',
                        style: const TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      DropdownButton<String>(
                        value: selectedSort,
                        onChanged: (newSort) {
                          setState(() {
                            selectedSort = newSort!;
                            applySort();
                          });
                        },
                        items: const [
                          DropdownMenuItem(value: "등록순", child: Text("등록순")),
                          DropdownMenuItem(value: "즐겨찾기순", child: Text("즐겨찾기순")),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFF3F3F3),
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: filteredUsers.isEmpty
                  ? const Center(
                child: Text(
                  "검색 결과가 없습니다.",
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              )
                  : ListView.builder(
                padding: const EdgeInsets.only(top: 20),
                itemCount: filteredUsers.length,
                itemBuilder: (context, index) {
                  final user = filteredUsers[index];
                  return GestureDetector(
                    onTap: () {
                      Auth auth = Auth(
                        name: user["name"],
                        id: user["id"] ?? "",
                        department: user["team"] ?? "",
                        joinDate: user["joinDate"] ?? "",
                        jobGroup: user["job"] ?? "",
                        profileImage: user["profileImage"] ?? "assets/images/default_profile.png",
                        yearlyExperience: const {}, // Default for this example
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AuthProfileScreen(auth: auth),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(11),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundImage: AssetImage(_getProfileImage(user)),
                                backgroundColor: Colors.grey[200],
                              ),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    user["name"],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    "소속: ${user["team"]} | 직군: ${user["job"]}",
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          IconButton(
                            icon: Icon(
                              user["isStarred"] ? Icons.star : Icons.star_border,
                              color: user["isStarred"] ? Colors.yellow : Colors.grey,
                            ),
                            onPressed: () => toggleStar(index),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showAddUserDialog,
        backgroundColor: const Color(0xFF2E9629),
        shape: CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
