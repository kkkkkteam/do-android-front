class Auth {
  final String name;
  final String id;
  final String department;
  final String joinDate;
  final String jobGroup;
  final Map<String, int> yearlyExperience;

  Auth({
    required this.name,
    required this.id,
    required this.department,
    required this.joinDate,
    required this.jobGroup,
    required this.yearlyExperience,
  });

  int get totalExperience => yearlyExperience.values.fold(0, (sum, value) => sum + value);
}
