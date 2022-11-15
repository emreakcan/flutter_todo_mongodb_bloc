import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todos_api/todos_api.dart';

class ApiService {
  final String apiUrl = 'http://127.0.0.1:7777/';

  Future<List<Todo>> fetchTodos(String userId) async {
    final response = await http.get(Uri.parse('${apiUrl}get_todos/params?user_id=$userId'));

    print(response.body.toString());

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      return (json.decode(response.body) as List)
          .map((data) => Todo.fromJson({'title': data['title']}))
          .toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load todos');
    }
  }
}
