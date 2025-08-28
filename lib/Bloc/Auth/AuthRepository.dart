import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthRepository {
  Future<String> login(String email, String password) async {
    final url = Uri.parse("https://api.escuelajs.co/api/v1/auth/login");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return data['access_token'];
    } else {
      throw Exception("Username atau password salah");
    }
  }
}
