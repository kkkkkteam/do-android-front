import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../utils/constants.dart';
import '../../utils/token_storage.dart';
import '../../models/admin/user.dart';

class UserService{
  static Future<User?> SearchUserByUserId(int user_id) async {
    final tokenStorage = TokenStorage();
    String access_token = tokenStorage.getAccessToken() as String;
    final url = Uri.parse('$apiBaseUrl/api/v1/admin/user/${user_id}');
    final headers = {
      'Authorization': 'Bearer ${access_token}'
    };
    final response = await http.post(
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
}