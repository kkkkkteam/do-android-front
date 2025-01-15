class DataItem {
  final int id;
  final String name;
  final String description;
  final int permission;
  final DateTime createdAt;

  DataItem({
    required this.id,
    required this.name,
    required this.description,
    required this.permission,
    required this.createdAt,
  });

  factory DataItem.fromJson(Map<String, dynamic> json) {
    return DataItem(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      permission: json['permission'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}

class DataResponse {
  final List<DataItem> data;

  DataResponse({
    required this.data,
  });

  factory DataResponse.fromJson(Map<String, dynamic> json) {
    return DataResponse(
      data: (json['data'] as List).map((item) => DataItem.fromJson(item)).toList(),
    );
  }
}