import 'package:flutter/material.dart';
import 'admin_widgets.dart';

class AdminUserList extends StatefulWidget {
  const AdminUserList({super.key});

  @override
  State<AdminUserList> createState() => AdminUserListState();
}

class AdminUserListState extends State<AdminUserList> {
  final List<Map<String, dynamic>> users = [
    {
      "name": "고경수",
      "level": "LV.F1-2",
      "team": "음성 1센터",
      "job": "치킨마요덮밥",
      "isStarred": true,
      "starOrder": 1,
      "profileUrl": "https://via.placeholder.com/150"
    },
  ];

  List<Map<String, dynamic>> filteredUsers = [];
  String searchQuery = "";
  String selectedSort = "등록순";

  @override
  void initState() {
    super.initState();
    filteredUsers = List.from(users);
    applySort();
  }

  void addUser(String name, String team, String job) {
    setState(() {
      final newUser = {
        "name": name,
        "level": "LV.F1-1",
        "team": team,
        "job": job,
        "isStarred": false,
        "starOrder": null,
        "profileUrl": "https://via.placeholder.com/150",
      };
      users.add(newUser);
      filteredUsers.add(newUser);
      applySort();
    });
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

      int userIndex = users.indexWhere((user) => user["name"] == filteredUsers[index]["name"]);
      users[userIndex] = filteredUsers[index];
      applySort();
    });
  }

  void filterUsers(String query) {
    setState(() {
      searchQuery = query;
      filteredUsers = users.where((user) {
        return user["name"].contains(query) || user["team"].contains(query) || user["job"].contains(query);
      }).toList();
      applySort();
    });
  }

  void applySort() {
    if (selectedSort == "즐겨찾기순") {
      filteredUsers.sort((a, b) {
        if (a["isStarred"] && b["isStarred"]) {
          return a["starOrder"]!.compareTo(b["starOrder"]!);
        } else if (a["isStarred"]) {
          return -1;
        } else if (b["isStarred"]) {
          return 1;
        } else {
          return 0;
        }
      });
    } else {
      filteredUsers = users.where((user) {
        return user["name"].contains(searchQuery) || user["team"].contains(searchQuery) || user["job"].contains(searchQuery);
      }).toList();
    }
  }

  void changeSort(String? newSort) {
    setState(() {
      selectedSort = newSort!;
      applySort();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const AdminAppBar(),
        SliverToBoxAdapter(
          child: AdminSearchAndSort(
            userCount: users.length,
            selectedSort: selectedSort,
            onSearch: filterUsers,
            onSortChange: changeSort,
          ),
        ),
        SliverFillRemaining(
          child: filteredUsers.isEmpty
              ? const AdminEmptyState()
              : AdminUserListView(
                  users: filteredUsers,
                  onStarToggle: toggleStar,
                ),
        ),
      ],
    );
  }
}
