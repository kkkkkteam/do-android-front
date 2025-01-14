import 'package:flutter/material.dart';

class AdminAppBar extends StatelessWidget {
  const AdminAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.white,
      pinned: true,
      elevation: 0,
      title: Row(
        children: [
          const Text(
            '관리자 홈',
            style: TextStyle(color: Colors.black),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

class AdminSearchAndSort extends StatelessWidget {
  final int userCount;
  final String selectedSort;
  final Function(String) onSearch;
  final Function(String?) onSortChange;

  const AdminSearchAndSort({
    super.key,
    required this.userCount,
    required this.selectedSort,
    required this.onSearch,
    required this.onSortChange,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            onChanged: onSearch,
            decoration: InputDecoration(
              hintText: '소속, 직급 또는 이름을 검색하세요',
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('총 $userCount 명'),
              DropdownButton<String>(
                value: selectedSort,
                onChanged: onSortChange,
                items: const [
                  DropdownMenuItem(value: "등록순", child: Text("등록순")),
                  DropdownMenuItem(value: "즐겨찾기순", child: Text("즐겨찾기순")),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AdminEmptyState extends StatelessWidget {
  const AdminEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.error_outline, size: 50, color: Colors.grey),
          SizedBox(height: 10),
          Text('검색 결과가 없습니다.', style: TextStyle(fontSize: 16, color: Colors.grey)),
        ],
      ),
    );
  }
}

class AdminUserListView extends StatelessWidget {
  final List<Map<String, dynamic>> users;
  final Function(int) onStarToggle;

  const AdminUserListView({super.key, required this.users, required this.onStarToggle});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return Container(
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
                    backgroundColor: Colors.grey[200],
                    child: Text(user["name"][0]),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user["name"], style: const TextStyle(fontSize: 13)),
                      Text("소속: ${user["team"]}\n직급: ${user["job"]}",
                          style: const TextStyle(fontSize: 11, color: Colors.grey)),
                    ],
                  ),
                ],
              ),
              IconButton(
                icon: Icon(
                  user["isStarred"] ? Icons.star : Icons.star_border,
                  color: user["isStarred"] ? Colors.yellow : Colors.grey,
                ),
                onPressed: () => onStarToggle(index),
              ),
            ],
          ),
        );
      },
    );
  }
}
