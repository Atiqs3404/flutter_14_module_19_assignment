import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todo_app/utils/urls.dart';

class TodoController {
  List<dynamic> taskList = [];

  Future<void> getTasks() async {
    final url = Uri.parse(Urls.getAllTask);

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      if (decoded is List) {
        taskList = decoded;
      } else if (decoded is Map<String, dynamic> && decoded["data"] is List) {
        taskList = decoded["data"] as List<dynamic>;
      } else {
        taskList = [];
      }
    }
  }

  Future<bool> createTasks({
    required String title,
    required String description,
  }) async {
    final url = Uri.parse(Urls.createTask);

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},

      body: jsonEncode({"title": title, "description": description}),
    );

    if (response.statusCode == 200) {
      getTasks();
      return true;
    }
    return false;
  }

  Future<bool> deleteTasks(String id) async {
    final url = Uri.parse(Urls.deleteTask(id));

    final response = await http.delete(url);

    if (response.statusCode == 200) {
      getTasks();

      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateTasks(
    String id, {
    required String title,
    required String description,
  }) async {
    final url = Uri.parse(Urls.updateTask(id));

    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},

      body: jsonEncode({"title": title, "description": description}),
    );

    if (response.statusCode == 200) {
      getTasks();
      return true;
    }
    return false;
  }
}
