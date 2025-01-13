import 'package:flutter/material.dart';
import 'admin_user_list.dart';

class AdminMainScreen extends StatelessWidget {
  AdminMainScreen({super.key});

  final GlobalKey<AdminUserListState> userListKey = GlobalKey<AdminUserListState>();

  void showAddUserDialog(BuildContext context) {
    String name = "";
    String team = "";
    String job = "";

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("새 사용자 추가"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) => name = value,
                decoration: const InputDecoration(labelText: "이름"),
              ),
              TextField(
                onChanged: (value) => team = value,
                decoration: const InputDecoration(labelText: "소속"),
              ),
              TextField(
                onChanged: (value) => job = value,
                decoration: const InputDecoration(labelText: "직급"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("취소"),
            ),
            TextButton(
              onPressed: () {
                if (name.isNotEmpty && team.isNotEmpty && job.isNotEmpty) {
                  userListKey.currentState?.addUser(name, team, job);
                  Navigator.of(context).pop();
                }
              },
              child: const Text("추가"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AdminUserList(key: userListKey),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAddUserDialog(context),
        backgroundColor: Colors.green,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          size: 28,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "홈"),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: "게시글"),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: "소속 및 그룹"),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "경험치"),
        ],
      ),
    );
  }
}
