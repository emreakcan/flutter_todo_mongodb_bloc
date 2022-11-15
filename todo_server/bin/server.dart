import 'package:mongo_dart/mongo_dart.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'home_controller.dart';
import 'dart:io' show Platform;

void main() async {
  // Variable for PORT
  Map<String, String> envVars = Platform.environment;
  var portEnv = envVars['PORT'];
  var PORT = portEnv == null ? 7777 : int.parse(portEnv);

  String host = Platform.environment['MONGO_DART_DRIVER_HOST'] ?? '127.0.0.1';
  String port = Platform.environment['MONGO_DART_DRIVER_PORT'] ?? '27017';

  var db = Db('mongodb://$host:$port/mongo_dart-blog');
  await db.open();

  //Instantiate Home Controller
  final home = HomeController(db);
  // Create server
  final server = await shelf_io.serve(home.handler, '127.0.0.1', PORT);
  // Server on message
  print('☀️ Server running on http://localhost:${server.port} ☀️');
}
