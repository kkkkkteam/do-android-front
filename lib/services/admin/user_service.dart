import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../utils/constants.dart';
import '../../utils/token_storage.dart';
import '../../models/admin/user.dart';
import '../../models/admin/user_profile.dart';

class UserService{
  static Future<User?> SearchUserByUserId(int user_id) async {
    final tokenStorage = TokenStorage();
    String access_token = tokenStorage.getAccessToken() as String;
    final url = Uri.parse('$apiBaseUrl/api/v1/admin/user/${user_id}');
    final headers = {
      'Authorization': 'Bearer ${access_token}'
    };
    final response = await http.get(
      url,
      headers: headers,
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return User.fromJson(data);
    } else {
      final errorData = json.decode(response.body);
      throw Exception(errorData['detail'] ?? '정보 가져오기 실패');
    }
  }
  static Future<UsersResponse?> UsersPage(int page, int perPage) async {
    final tokenStorage = TokenStorage();
    String access_token = tokenStorage.getAccessToken() as String;
    final headers = {
      'Authorization': 'Bearer ${access_token}'
    };
    final url = Uri.parse(
        'https://your-api-domain.com/api/v1/admin/users?page=$page&per_page=$perPage');
    try {
      final response = await http.get(
        url,
        headers: headers,
      );

      if (response.statusCode == 200) {
        return UsersResponse.fromJson(jsonDecode(response.body));

      } else {
        print('Failed to fetch users. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }
}