import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../utils/constants.dart';
import '../../utils/token_storage.dart';
import '../../models/common/data_item.dart';

class ArticleService{
  static Future<DataResponse?> commonArticle(String username, String password) async {
    final tokenStorage = TokenStorage();
    String access_token = tokenStorage.getAccessToken() as String;
    final url = Uri.parse('$apiBaseUrl/api/v1/common/article/type');
    final headers = {
      'Authorization': 'Bearer ${access_token}'
    };

    final response = await http.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return DataResponse.fromJson(data);
    } else {
      final errorData = json.decode(response.body);
      throw Exception(errorData['detail'] ?? '정보 가져오기 실패');
    }
  }
}