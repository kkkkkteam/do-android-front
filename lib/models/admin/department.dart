class Department {
  final int id;
  final String name;

  Department({
    required this.id,
    required this.name,
  });

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
      id: json['id'],
      name: json['name'],
    );
  }
}

class DepartmentsResponse {
  final List<Department> data;

  DepartmentsResponse({
    required this.data,
  });

  factory DepartmentsResponse.fromJson(Map<String, dynamic> json) {
    var dataJson = json['data'] as List;
    List<Department> dataList = dataJson.map((e) => Department.fromJson(e)).toList();

    return DepartmentsResponse(data: dataList);
  }
}