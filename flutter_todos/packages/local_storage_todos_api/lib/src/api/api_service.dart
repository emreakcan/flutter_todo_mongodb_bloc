import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todos_api/todos_api.dart';

class ApiService {
  final String apiUrl = 'http://127.0.0.1:7777/';

  Future<List<Todo>> fetchTodos(String userId) async {
    final response = await http.get(Uri.parse('${apiUrl}get_todos/params?user_id=$userId'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      return (json.decode(response.body) as List)
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
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load todos');
    }
  }

  Future<String> addTodo(Todo todo, String userId) async {
    final response = await http.get(
      Uri.parse(
        '${apiUrl}add_todo/params?user_id=$userId&title=${todo.title}&description=${todo.description}&id=${todo.id}&is_completed=${todo.isCompleted}',
      ),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return jsonEncode(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load todos');
    }
  }

  Future<String> editTodo(Todo todo, String userId) async {
    final response = await http.get(
      Uri.parse(
        '${apiUrl}edit_todo/params?user_id=$userId&title=${todo.title}&description=${todo.description}&id=${todo.id}&is_completed=${todo.isCompleted}',
      ),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return jsonEncode(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load todos');
    }
  }

  Future<String> removeTodo(String id) async {
    final response = await http.get(
      Uri.parse(
        '${apiUrl}remove_todo/params?todo_id=$id',
      ),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return jsonEncode(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load todos');
    }
  }
}
