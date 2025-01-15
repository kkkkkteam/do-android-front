class JobGroup {
  final int id;
  final String name;

  JobGroup({
    required this.id,
    required this.name,
  });

  factory JobGroup.fromJson(Map<String, dynamic> json) {
    return JobGroup(
      id: json['id'],
      name: json['name'],
    );
  }
}

class JobGroupsResponse {
  final List<JobGroup> data;

  JobGroupsResponse({
    required this.data,
  });

  factory JobGroupsResponse.fromJson(Map<String, dynamic> json) {
    var dataJson = json['data'] as List;
    List<JobGroup> dataList = dataJson.map((e) => JobGroup.fromJson(e)).toList();

    return JobGroupsResponse(data: dataList);
  }
}