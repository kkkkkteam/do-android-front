import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/common/jwt_token.dart'; // JwtToken 모델 임포트
import '../../utils/constants.dart';
import '../../utils/token_storage.dart';

class AuthService {

  static Future<JwtToken?> login(String username, String password) async {
    final url = Uri.parse('$apiBaseUrl/api/v1/common/auth/login');

    final headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
    };

    final body = {
      'username': username,
      'password': password,
    };

    final response = await http.post(
      url,
      //headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return JwtToken.fromJson(data);
    } else {
      final errorData = json.decode(response.body);
      throw Exception(errorData['detail'] ?? '로그인 실패');
    }
  }

  static Future<JwtToken?> refresh() async { // statusCode가 401이면 이 함수 호출하기
    final tokenStorage = TokenStorage();
    String refresh_token = tokenStorage.getRefreshToken() as String;

    final url = Uri.parse('$apiBaseUrl/api/v1/common/auth/refresh/');

    final headers = {'Authorization': 'Bearer ${refresh_token}'};

    final response = await http.post(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return JwtToken.fromJson(data);
    } else {
      final errorData = json.decode(response.body);
      throw Exception(errorData['detail'] ?? '리프레시 실패');
    }
  }

  static Future<JwtToken?> logout() async {
    final tokenStorage = TokenStorage();
    String access_token = tokenStorage.getAccessToken() as String;

    final url = Uri.parse('$apiBaseUrl/api/v1/common/auth/logout/');

    final headers = {'Authorization': 'Bearer ${access_token}'};

    final response = await http.post(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      tokenStorage.clearTokens();
    } else {
      final errorData = json.decode(response.body);
      throw Exception(errorData['detail'] ?? '로그아웃 실패');
    }
  }
}