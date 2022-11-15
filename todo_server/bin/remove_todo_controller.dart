import 'package:mongo_dart/mongo_dart.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf.dart';

class RemoveTodoController {
  Db db;

  RemoveTodoController(this.db);

  Router get router {
    final router = Router();

    router.get('/', (Request req) {
      return Response.ok("Remove Todos Controller");
    });

    router.get('/<param>', (Request req, String param) async {
      print(req.url.queryParameters["todo_id"]); // accessing a url query

      await db.collection("todos").remove({"id": req.url.queryParameters["todo_id"]});

      return Response.ok(param);
    });

    router.all('/<ignored|.*>', (Request request) => Response.notFound('null'));

    return router;
  }
}
