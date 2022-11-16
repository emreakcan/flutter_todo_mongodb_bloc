import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todos_api/todos_api.dart';

class ApiService {
  final String apiUrl = 'http://127.0.0.1:7777/';

  Future<List<Todo>> fetchTodos(String userId) async {
    final response = await http.get(Uri.parse('${apiUrl}get_todos/params?user_id=$userId'));

    if (response.statusCode == 200) {
      return (response.body as List)
          .map(
            (data) => Todo.fromJson(
              {
                'title': data['title'],
                'description': data['description'],
                'id': data['id'],
                'is_completed': data['is_completed'],
                'user_id': data['user_id'],
              },
            ),
          )
          .toList();
    }

    throw Exception('Failed to load todos');
  }

  Future<String> addTodo(Todo todo, String userId) async {
    final response = await http.put(
      Uri.parse(
        '${apiUrl}add_todo/params?user_id=$userId&title=${todo.title}&description=${todo.description}&id=${todo.id}&is_completed=${todo.isCompleted}',
      ),
    );

    if (response.statusCode == 200) {
      return response.body;
    }

    throw Exception('Failed to add todo');
  }

  Future<String> editTodo(Todo todo, String userId) async {
    final response = await http.patch(
      Uri.parse(
        '${apiUrl}edit_todo/params?user_id=$userId&title=${todo.title}&description=${todo.description}&id=${todo.id}&is_completed=${todo.isCompleted}',
      ),
    );

    if (response.statusCode == 200) {
      return response.body;
    }

    throw Exception('Failed to edit todo');
  }

  Future<bool> removeTodo(String id) async {
    final response = await http.delete(
      Uri.parse(
        '${apiUrl}remove_todo/params?todo_id=$id',
      ),
    );

    return response.statusCode == 200;
  }
}
