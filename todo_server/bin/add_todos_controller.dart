import 'package:mongo_dart/mongo_dart.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf.dart';

class AddTodosController {
  Db db;

  AddTodosController(this.db);

  // By exposing a [Router] for an object, it can be mounted in other routers.
  Router get router {
    final router = Router();

    // get request to "/test"
    router.get('/', (Request req) {
      return Response.ok("Add Todos Controller");
    });

    // get request to "/test/<param>?query=????"
    router.get('/<param>', (Request req, String param) {
      print(req.url.queryParameters["title"]); // accessing a url query
      print(req.url.queryParameters["user_id"]); // accessing a url query

      db.collection("todos").insert({
        'id': DateTime.now().microsecondsSinceEpoch.toString(), //not really unique, although its not important
        'title': req.url.queryParameters["title"],
        'user_id': req.url.queryParameters["user_id"],
      });

      return Response.ok(param);
    });

    // catch all for "/test"
    router.all('/<ignored|.*>', (Request request) => Response.notFound('null'));

    return router;
  }
}
