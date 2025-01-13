import 'package:flutter/material.dart';

class AdminMainScreen extends StatefulWidget {
  const AdminMainScreen({Key? key}) : super(key: key);

  @override
  State<AdminMainScreen> createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> {
  List<Map<String, dynamic>> users = [
    {
      "name": "고경수",
      "team": "음성 1센터",
      "job": "치킨마요덮밥",
      "isStarred": true,
      "starOrder": 1672531200000, // 즐겨찾기 순서를 위한 timestamp
      "createdOrder": 1,
    },
    {
      "name": "이동건",
      "team": "음성 2센터",
      "job": "바보",
      "isStarred": true,
      "starOrder": 1672617600000,
      "createdOrder": 2,
    },
    {
      "name": "박찬",
      "team": "감자튀김센터",
      "job": "감자",
      "isStarred": false,
      "starOrder": null,
      "createdOrder": 3,
    },
    {
      "name": "장서인",
      "team": "치즈떡볶이센터",
      "job": "치즈",
      "isStarred": false,
      "starOrder": null,
      "createdOrder": 4,
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

  // 즐겨찾기 상태 변경
  void toggleStar(int index) {
    setState(() {
      if (filteredUsers[index]["isStarred"]) {
        filteredUsers[index]["isStarred"] = false;
        filteredUsers[index]["starOrder"] = null;
      } else {
        filteredUsers[index]["isStarred"] = true;
        filteredUsers[index]["starOrder"] = DateTime.now().millisecondsSinceEpoch;
      }

      // 전체 데이터 업데이트
      int userIndex = users.indexWhere((user) =>
          user["name"] == filteredUsers[index]["name"]);
      users[userIndex] = filteredUsers[index];

      // 현재 정렬 상태 유지
      applySort();
    });
  }

  // 검색 필터링
  void filterUsers(String query) {
    setState(() {
      searchQuery = query;
      filteredUsers = users.where((user) {
        bool matchesQuery = user["name"].contains(query) ||
            user["team"].contains(query) ||
            user["job"].contains(query);
        return matchesQuery;
      }).toList();

      // 검색 후에도 정렬 상태 유지
      applySort();
    });
  }

  // 정렬 적용
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
      // 등록순
      filteredUsers.sort((a, b) => a["createdOrder"].compareTo(b["createdOrder"]));
    }
  }

  // 정렬 선택 콤보박스 로직
  void changeSort(String? newSort) {
    setState(() {
      selectedSort = newSort!;
      applySort();
    });
  }

  // 사원 추가 다이얼로그
    void showAddUserDialog() {
  String name = "";
  String id = "";
  String team = "";
  String joinDate = "";
  String jobGroup = "";

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
                GestureDetector(
                  onTap: () {
                    // 프로필 사진 선택 로직 추가
                    print("프로필 사진 선택 클릭됨");
                  },
                  child: Column(
                    children: const [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Color(0xFFE8F5E9), // 연한 초록색
                        child: Icon(
                          Icons.person,
                          color: Color(0xFF2E9629), // 초록색 아이콘
                          size: 50,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "프로필 사진 선택",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  onChanged: (value) => name = value,
                  decoration: InputDecoration(
                    labelText: "이름",
                    labelStyle: const TextStyle(color: Color(0xFF2E9629)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFF2E9629), width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFF2E9629), width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  onChanged: (value) => id = value,
                  decoration: InputDecoration(
                    labelText: "사번",
                    labelStyle: const TextStyle(color: Color(0xFF2E9629)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFF2E9629), width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFF2E9629), width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  onChanged: (value) => team = value,
                  decoration: InputDecoration(
                    labelText: "소속",
                    labelStyle: const TextStyle(color: Color(0xFF2E9629)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFF2E9629), width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFF2E9629), width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  onChanged: (value) => joinDate = value,
                  decoration: InputDecoration(
                    labelText: "입사일",
                    labelStyle: const TextStyle(color: Color(0xFF2E9629)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFF2E9629), width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFF2E9629), width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "예: 2023-01-01",
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  onChanged: (value) => jobGroup = value,
                  decoration: InputDecoration(
                    labelText: "직무그룹",
                    labelStyle: const TextStyle(color: Color(0xFF2E9629)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFF2E9629), width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFF2E9629), width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (name.isNotEmpty &&
                        id.isNotEmpty &&
                        team.isNotEmpty &&
                        joinDate.isNotEmpty &&
                        jobGroup.isNotEmpty) {
                      setState(() {
                        users.add({
                          "name": name,
                          "id": id,
                          "team": team,
                          "joinDate": joinDate,
                          "jobGroup": jobGroup,
                          "isStarred": false,
                          "createdOrder": users.length + 1,
                        });
                        filteredUsers = List.from(users);
                      });
                      applySort(); // 추가 후 정렬 적용
                      Navigator.pop(context);
                    } else {
                      print("모든 필드를 입력해야 합니다.");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E9629),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: const Text(
                    "계정 생성",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
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
              style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontFamily: 'RubikScribble'),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    onChanged: filterUsers,
                    decoration: InputDecoration(
                      hintText: '이름, 소속 또는 직급을 검색하세요',
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(color: Colors.grey[300]!, width: 1.5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.green, width: 1.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.green, width: 1.5),
                      ),
                    ),
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
                        onChanged: changeSort,
                        items: const [
                          DropdownMenuItem(
                            value: "등록순",
                            child: Text("등록순"),
                          ),
                          DropdownMenuItem(
                            value: "즐겨찾기순",
                            child: Text("즐겨찾기순"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // 사용자 리스트 표시
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
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
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
                                    backgroundColor: Colors.grey[200],
                                    child: Text(user["name"][0]),
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
                                        "소속: ${user["team"]} | 직급: ${user["job"]}",
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              IconButton(
                                icon: Icon(
                                  user["isStarred"]
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: user["isStarred"]
                                      ? Colors.yellow
                                      : Colors.grey,
                                ),
                                onPressed: () => toggleStar(index),
                              ),
                            ],
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
        backgroundColor: Colors.green,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
