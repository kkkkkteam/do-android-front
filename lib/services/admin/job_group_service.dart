import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../utils/constants.dart';
import '../../utils/token_storage.dart';
import '../../models/admin/job_group.dart';

class JobGroupService{
  static Future<bool> AddJobGroup(String name) async {
    final tokenStorage = TokenStorage();
    String access_token = tokenStorage.getAccessToken() as String;
    final url = Uri.parse('$apiBaseUrl/api/v1/admin/job_group');
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
  static Future<JobGroupsResponse?> GetJobGroups() async {
    final tokenStorage = TokenStorage();
    String access_token = tokenStorage.getAccessToken() as String;
    final url = Uri.parse('$apiBaseUrl/api/v1/admin/job_groups');
    final headers = {
      'Authorization': 'Bearer ${access_token}'
    };
    final response = await http.get(
      url,
      headers: headers,
    );
    if (response.statusCode==200){
      final data = json.decode(response.body);
      return JobGroupsResponse.fromJson(data);
    } else {
      final errorData = json.decode(response.body);
      throw Exception(errorData['detail'] ?? '정보 가져오기 실패');
    }
  }
  static Future<bool> EditJobGroup(int job_group_id,String name) async {
    final tokenStorage = TokenStorage();
    String access_token = tokenStorage.getAccessToken() as String;
    final url = Uri.parse('$apiBaseUrl/api/v1/admin/job_group/${job_group_id}');
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
  static Future<bool> DeleteJobGroup(int job_group_id) async {
    final tokenStorage = TokenStorage();
    String access_token = tokenStorage.getAccessToken() as String;
    final url = Uri.parse('$apiBaseUrl/api/v1/admin/job_group/${job_group_id}');
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