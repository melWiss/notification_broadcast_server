import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

import 'middleware.dart';
import 'notify.dart';

Response _echoHandler(Request request) {
  final message = request.params['message'];
  return Response.ok('$message\n');
}

void main(List<String> args) async {
  // Use any available host or container IP (usually `0.0.0.0`).
  if (args.isNotEmpty) {
    final ip = InternetAddress("0.0.0.0");
    password = args.last;
    NotificationRouter notificationRouter = NotificationRouter();
    Router router = Router();
    router.mount("/notifications", notificationRouter.route);

    // Configure a pipeline that logs requests.
    final handler = Pipeline()
        .addMiddleware(logRequests())
        .addMiddleware(authenticate)
        .addHandler(router);

    // For running in containers, we respect the PORT environment variable.
    final port = int.parse(Platform.environment['PORT'] ?? '8088');
    final server = await serve(handler, ip, port);
    print('Server listening on port ${server.port}');
  } else {
    throw "NO_PASSWORD";
  }
}
