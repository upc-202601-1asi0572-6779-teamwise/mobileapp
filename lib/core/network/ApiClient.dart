import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  static String get baseUrl => dotenv.env['API_BASE_URL']!;

  static Future<dynamic> get(String path) async {
    final res = await http.get(Uri.parse('$baseUrl$path'));
    if (res.statusCode != 200) throw Exception('HTTP ${res.statusCode}');
    return jsonDecode(utf8.decode(res.bodyBytes));
  }

  static Future<dynamic> post(String path, Map<String, dynamic> body) async {
    final res = await http.post(
      Uri.parse('$baseUrl$path'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
    if (res.statusCode != 201) throw Exception('HTTP ${res.statusCode}');
    return jsonDecode(utf8.decode(res.bodyBytes));
  }
}
