import 'package:http/http.dart' as http;
import 'dart:convert';
import 'api_endpoints.dart';

class ApiService {
  // Fungsi terpusat untuk Register
  static Future<http.Response> registerUser(String nama, String email, String password) async {
    final url = Uri.parse(ApiEndpoints.register);
    
    return await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "nama": nama,
        "email": email,
        "password": password,
      }),
    );
  }

  // Fungsi terpusat untuk Login
  static Future<http.Response> loginUser(String email, String password) async {
    final url = Uri.parse(ApiEndpoints.login);
    
    return await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );
  }
}