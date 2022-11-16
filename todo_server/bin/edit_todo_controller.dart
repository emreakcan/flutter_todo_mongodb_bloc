import 'package:mongo_dart/mongo_dart.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf.dart';

class EditTodoController {
  Db db;

  EditTodoController(this.db);

  // By exposing a [Router] for an object, it can be mounted in other routers.
  Router get router {
    final router = Router();

    router.patch('/', (Request req) {
      return Response.ok("Edit Todos Controller");
    });

    router.patch('/<param>', (Request req, String param) {

      db.collection("todos").replaceOne({"id": req.url.queryParameters["id"]},{
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
