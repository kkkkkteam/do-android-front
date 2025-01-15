import 'package:http/http.dart' as http;
import '../../utils/constants.dart';
import '../../utils/token_storage.dart';

class AuthRegister {

  static Future<bool> Register(String employee_id, String username, String name, String password) async {
    final url = Uri.parse('$apiBaseUrl/api/v1/admin/auth/register');

    final body = {
      "employee_id": employee_id,
      "username": username,
      "name": name,
      "password": password
    };

    final response = await http.post(
      url,
      body: body,
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> RegisterUser(String employee_id, String username, String name, String password) async {
    final tokenStorage = TokenStorage();
    String access_token = tokenStorage.getAccessToken() as String;
    final url = Uri.parse('$apiBaseUrl/api/v1/admin/auth/register_user');
    final headers = {'Authorization': 'Bearer ${access_token}'};
    final body = {
      "employee_id": employee_id,
      "username": username,
      "name": name,
      "password": password
    };

    final response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}