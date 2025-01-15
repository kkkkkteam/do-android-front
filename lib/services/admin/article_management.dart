import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../utils/constants.dart';
import '../../utils/token_storage.dart';
import '../../models/admin/article.dart';

class ArticleManagement{
  static Future<bool> addArticle(String title, String content, int article_type_id) async {
    final tokenStorage = TokenStorage();
    String access_token = tokenStorage.getAccessToken() as String;
    final url = Uri.parse('$apiBaseUrl/api/v1/admin/article');
    final headers = {
      'Authorization': 'Bearer ${access_token}'
    };
    final body = {'title':title, 'content':content, 'article_type_id':article_type_id};
    final response = await http.post(
      url,
      headers: headers,
      body: body
    );
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
  static Future<ArticlesResponse?> GetArticle(int page, int perPage) async {
    final tokenStorage = TokenStorage();
    String access_token = tokenStorage.getAccessToken() as String;
    final url = Uri.parse('$apiBaseUrl/api/v1/admin/article?page=$page&per_page=$perPage');
    final headers = {
      'Authorization': 'Bearer ${access_token}'
    };
    try {
      final response = await http.get(
          url,
          headers: headers,
      );

      if (response.statusCode == 200) {
        return ArticlesResponse.fromJson(jsonDecode(response.body));

      } else {
        print('Failed to fetch users. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }
}