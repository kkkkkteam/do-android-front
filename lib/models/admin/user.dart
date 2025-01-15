class User {
  final String username;
  final String employeeId;
  final String departmentName;
  final DateTime joinDate;
  final String jobGroupName;
  final int totalExp;
  final List<YearlyExperience> eachYearExp;

  User({
    required this.username,
    required this.employeeId,
    required this.departmentName,
    required this.joinDate,
    required this.jobGroupName,
    required this.totalExp,
    required this.eachYearExp,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      employeeId: json['employee_id'],
      departmentName: json['department_name'],
      joinDate: DateTime.parse(json['join_date']),
      jobGroupName: json['job_group_name'],
      totalExp: json['total_exp'],
      eachYearExp: (json['each_year_exp'] as List)
          .map((e) => YearlyExperience.fromJson(e))
          .toList(),
    );
  }
}

class YearlyExperience {
  final int year;
  final int totalExp;

  YearlyExperience({
    required this.year,
    required this.totalExp,
  });

  factory YearlyExperience.fromJson(Map<String, dynamic> json) {
    return YearlyExperience(
      year: json['year'],
      totalExp: json['total_exp'],
    );
  }
}