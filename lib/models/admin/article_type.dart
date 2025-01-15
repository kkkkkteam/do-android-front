class ArticleType {
  final int id;
  final String name;
  final String description;
  final int permission;
  final DateTime createdAt;

  ArticleType({
    required this.id,
    required this.name,
    required this.description,
    required this.permission,
    required this.createdAt,
  });

  factory ArticleType.fromJson(Map<String, dynamic> json) {
    return ArticleType(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      permission: json['permission'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}

class ArticleTypesResponse {
  final List<ArticleType> data;

  ArticleTypesResponse({
    required this.data,
  });

  factory ArticleTypesResponse.fromJson(Map<String, dynamic> json) {
    var dataJson = json['data'] as List;
    List<ArticleType> dataList = dataJson.map((e) => ArticleType.fromJson(e)).toList();

    return ArticleTypesResponse(data: dataList);
  }
}