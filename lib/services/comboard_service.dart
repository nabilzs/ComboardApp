import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ComboardService {
  final String _baseUrl = 'https://edu-demo.amatraedu.com:8081/api/v1';

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  Future<List<dynamic>> fetchComboard({int skip = 0}) async {
    final token = await _getToken(); // ✅ ambil token dari storage
    if (token == null) {
      throw Exception("Token tidak ditemukan. Silakan login kembali.");
    }

    final url = Uri.parse(
      '$_baseUrl/comboard-admin'
      '?user_parent_id=0088dffb-01cb-4354-81b3-e49978b60128'
      '&skip=$skip'
      '&roles=ROLE_ADMIN%2C',
    );

    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token', // ✅ tambahin prefix Bearer
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['data'] ?? [];
    } else {
      throw Exception('Failed to load comboard data: ${response.statusCode}');
    }
  }
}
