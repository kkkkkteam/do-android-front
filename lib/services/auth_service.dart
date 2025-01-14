// lib/services/auth_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/jwt_token.dart'; // JwtToken 모델 임포트
import '../utils/constants.dart';

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
}