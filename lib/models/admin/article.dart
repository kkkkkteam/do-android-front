class Article {
  final int id;
  final String title;
  final String content;
  final DateTime createdAt;
  final int viewCount;
  final int authorId;
  final int articleTypeId;

  Article({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.viewCount,
    required this.authorId,
    required this.articleTypeId,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      createdAt: DateTime.parse(json['created_at']),
      viewCount: json['view_count'],
      authorId: json['author_id'],
      articleTypeId: json['article_type_id'],
    );
  }
}

class ArticlesResponse {
  final List<Article> data;

  ArticlesResponse({
    required this.data,
  });

  factory ArticlesResponse.fromJson(Map<String, dynamic> json) {
    var dataJson = json['data'] as List;
    List<Article> dataList = dataJson.map((e) => Article.fromJson(e)).toList();

    return ArticlesResponse(data: dataList);
  }
}