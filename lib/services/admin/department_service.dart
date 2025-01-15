import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../utils/constants.dart';
import '../../utils/token_storage.dart';
import '../../models/admin/department.dart';

class JobGroupService{
  static Future<bool> AddDepartment(String name) async {
    final tokenStorage = TokenStorage();
    String access_token = tokenStorage.getAccessToken() as String;
    final url = Uri.parse('$apiBaseUrl/api/v1/admin/department');
    final headers = {
      'Authorization': 'Bearer ${access_token}'
    };
    final body = {"name": name};
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
  static Future<DepartmentsResponse?> GetDepartment() async {
    final tokenStorage = TokenStorage();
    String access_token = tokenStorage.getAccessToken() as String;
    final url = Uri.parse('$apiBaseUrl/api/v1/admin/departments');
    final headers = {
      'Authorization': 'Bearer ${access_token}'
    };
    final response = await http.get(
      url,
      headers: headers,
    );
    if (response.statusCode==200){
      final data = json.decode(response.body);
      return DepartmentsResponse.fromJson(data);
    } else {
      final errorData = json.decode(response.body);
      throw Exception(errorData['detail'] ?? '정보 가져오기 실패');
    }
  }
  static Future<bool> EditDepartment(int department_id,String name) async {
    final tokenStorage = TokenStorage();
    String access_token = tokenStorage.getAccessToken() as String;
    final url = Uri.parse('$apiBaseUrl/api/v1/admin/department/${department_id}');
    final headers = {
      'Authorization': 'Bearer ${access_token}'
    };
    final body = {'name':name};
    final response = await http.put(
        url,
        headers: headers,
        body: body
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
  static Future<bool> DeleteDepartment(int department_id) async {
    final tokenStorage = TokenStorage();
    String access_token = tokenStorage.getAccessToken() as String;
    final url = Uri.parse('$apiBaseUrl/api/v1/admin/department/${department_id}');
    final headers = {
      'Authorization': 'Bearer ${access_token}'
    };
    final response = await http.delete(
      url,
      headers: headers,
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}