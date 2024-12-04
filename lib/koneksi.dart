import 'dart:convert';
import 'package:http/http.dart' as http;
import 'model.dart';

class NewsService {
  final client = http.Client();
  final String baseUrl =
      'http://192.168.56.1:3000/news'; // Sesuaikan dengan server JSON Anda

  // Fungsi GET untuk mendapatkan semua berita
  Future<List<News>> fetchNews() async {
    final uri = Uri.parse(baseUrl);
    final response = await client.get(uri);

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data.map((news) => News.fromJson(news)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }
}

class UsersService {
  final client = http.Client();
  final String baseUrl =
      'http://192.168.56.1:3000/users'; // Sesuaikan dengan server JSON Anda

  Future<List<Users>> fetchUsers() async {
    final uri = Uri.parse(baseUrl);
    final response = await client.get(uri);

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data.map((users) => Users.fromJson(users)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }
}
