class Auth {
  final String name;
  final String id;
  final String department;
  final String joinDate;
  final String jobGroup;
  final String profileImage; // 프로필 이미지 필드
  final Map<String, int> yearlyExperience; // 연도별 경험치

  Auth({
    required this.name,
    required this.id,
    required this.department,
    required this.joinDate,
    required this.jobGroup,
    required this.profileImage,
    required this.yearlyExperience,
  });
}
