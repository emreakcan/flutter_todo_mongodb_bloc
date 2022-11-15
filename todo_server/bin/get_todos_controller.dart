import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf.dart';

import 'models/todo.dart';

class GetTodosController {
  Db db;

  GetTodosController(this.db);

  // By exposing a [Router] for an object, it can be mounted in other routers.
  Router get router {
    final router = Router();

    // get request to "/test"
    router.get('/', (Request req) {
      return Response.ok("Get Todos Controller");
    });

    // get request to "/test/<param>?query=????"
    router.get('/<param>', (Request req, String param) async {
      print(req.url.queryParameters["user_id"]); // accessing a url query

      List<Todo> todoList = [];

      await db.collection("todos").find({"user_id": req.url.queryParameters["user_id"]}).forEach((article) {
        todoList.add(Todo(title: article['title']));
      });

      print(todoList);

      return Response.ok(jsonEncode(todoList));
    });

    // catch all for "/test"
    router.all('/<ignored|.*>', (Request request) => Response.notFound('null'));

    return router;
  }
}
