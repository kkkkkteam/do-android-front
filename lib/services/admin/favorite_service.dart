import 'package:http/http.dart' as http;
import '../../utils/constants.dart';
import '../../utils/token_storage.dart';

class FavoriteService{
  static Future<bool> AddFavorite(int user_id) async {
    final tokenStorage = TokenStorage();
    String access_token = tokenStorage.getAccessToken() as String;
    final url = Uri.parse('$apiBaseUrl/api/v1/admin/favorite/${user_id}');
    final headers = {
      'Authorization': 'Bearer ${access_token}'
    };
    final response = await http.post(
      url,
      headers: headers,
    );
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
  static Future<bool> DeleteFavorite(int user_id) async {
    final tokenStorage = TokenStorage();
    String access_token = tokenStorage.getAccessToken() as String;
    final url = Uri.parse('$apiBaseUrl/api/v1/admin/favorite/${user_id}');
    final headers = {
      'Authorization': 'Bearer ${access_token}'
    };
    final response = await http.delete(
      url,
      headers: headers,
    );
    if (response.statusCode==200){
      return true;
    } else {
      return false;
    }
  }
}