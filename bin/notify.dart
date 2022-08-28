import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class NotificationRouter {
  Router _router = Router();

  Router get route => _router;

  NotificationRouter() {
    _router.post("/", (Request request) async {
      try {
        var body = jsonDecode(await request.readAsString()) as Map;
        await Process.run("notify-send", [body["title"], body["message"]]);
        return Response.ok(
          jsonEncode({"message": "done"}),
          headers: {"Content-Type": "application/json"},
        );
      } catch (e) {
        return Response.internalServerError(
          body: jsonEncode({
            "message": "Something went wrong",
            "error": e.toString(),
          }),
          headers: {"Content-Type": "application/json"},
        );
      }
    });
  }
}
