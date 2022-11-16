import 'package:mongo_dart/mongo_dart.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf.dart';

class AddTodoController {
  Db db;

  AddTodoController(this.db);

  // By exposing a [Router] for an object, it can be mounted in other routers.
  Router get router {
    final router = Router();

    router.put('/', (Request req) {
      return Response.ok("Add Todos Controller");
    });

    router.put('/<param>', (Request req, String param) {

      db.collection("todos").insert({
        'id': req.url.queryParameters["id"], //not really unique, although its not important
        'title': req.url.queryParameters["title"],
        'description': req.url.queryParameters["description"],
        'user_id': req.url.queryParameters["user_id"],
        'is_completed': req.url.queryParameters["is_completed"],
      });

      return Response.ok(param);
    });

    router.all('/<ignored|.*>', (Request request) => Response.notFound('null'));

    return router;
  }
}
