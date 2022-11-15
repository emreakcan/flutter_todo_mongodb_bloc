import 'package:mongo_dart/mongo_dart.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf.dart';
import './get_todos_controller.dart';
import 'add_todos_controller.dart';

class HomeController {
  Db db;

  HomeController(this.db);

  // Define our getter for our handler
  Handler get handler {
    final router = Router();

    // main route
    router.get('/', (Request request) {
      return Response.ok('Hello World');
    });

    // Mount Other Controllers Here
    router.mount('/get_todos/', GetTodosController(db).router);
    router.mount('/add_todos/', AddTodosController(db).router);

    // You can catch all verbs and use a URL-parameter with a regular expression
    // that matches everything to catch app.
    router.all('/<ignored|.*>', (Request request) {
      return Response.notFound('Page not found');
    });

    return router;
  }
}
