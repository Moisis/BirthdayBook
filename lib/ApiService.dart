import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static Future<List<dynamic>> fetchUsers() async {
    final response = await http.get(Uri.parse('https://dummyjson.com/users'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body)['users'];
      return data;
    } else {
      throw Exception('Failed to load users');
    }
  }
}
