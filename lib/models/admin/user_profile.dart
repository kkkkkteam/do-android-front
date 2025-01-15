class UserProfile {
  final int userId;
  final String name;
  final String departmentName;
  final String level;
  final String profileId;
  final bool isFavorite;

  UserProfile({
    required this.userId,
    required this.name,
    required this.departmentName,
    required this.level,
    required this.profileId,
    required this.isFavorite,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      userId: json['user_id'],
      name: json['name'],
      departmentName: json['department_name'],
      level: json['level'],
      profileId: json['profile_id'],
      isFavorite: json['is_favorite'],
    );
  }
}

class UsersResponse {
  final List<UserProfile> data;

  UsersResponse({required this.data});

  factory UsersResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<UserProfile> userList = list.map((i) => UserProfile.fromJson(i)).toList();

    return UsersResponse(data: userList);
  }
}