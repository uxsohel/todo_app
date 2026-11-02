import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/task.dart';
import '../models/user_model.dart'; // User model import kora holo

class ApiService {
  final String baseUrl = 'https://6ae7072156b2ee1e54400d1d.mockapi.io';

  // ===================== Task API ===================== //

  Future<List<Task>> getTasks() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/tasks'));
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        return jsonResponse.map((task) => Task.fromJson(task)).toList();
      } else {
        throw Exception('Failed to load tasks');
      }
    } catch (e) {
      throw Exception('API Error: $e');
    }
  }

  Future<bool> createTask(Task task) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/tasks'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(task.toJson()),
      );
      return response.statusCode == 201;
    } catch (e) {
      return false;
    }
  }

  // ===================== Auth API ===================== //

  Future<bool> signUpUser(UserModel user) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/user'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(user.toJson()),
      );
      return response.statusCode == 201;
    } catch (e) {
      return false;
    }
  }

  Future<UserModel?> signInUser(String email, String password) async {
    try {
      // MockAPI-te real auth nei, tai shob user get kore match korano hocche
      final response = await http.get(Uri.parse('$baseUrl/user'));
      if (response.statusCode == 200) {
        List users = json.decode(response.body);
        for (var u in users) {
          if (u['email'] == email && u['password'] == password) {
            return UserModel.fromJson(u);
          }
        }
      }
      return null; // Login failed
    } catch (e) {
      return null;
    }
  }
}