class AdminArticle {
  final String title;
  final String content;
  final int articleTypeId;

  AdminArticle({
    required this.title,
    required this.content,
    required this.articleTypeId,
  });

  factory AdminArticle.fromJson(Map<String, dynamic> json) {
    return AdminArticle(
      title: json['title'],
      content: json['content'],
      articleTypeId: json['article_type_id'],
    );
  }
}