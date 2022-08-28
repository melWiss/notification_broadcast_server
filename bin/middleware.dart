import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';

String password = "";

Middleware authenticate = createMiddleware(
  requestHandler: (request) {
    var token = request.headers['token'];
    var code = JWT.verify(token!, SecretKey("bananas in pyjamas"));
    var data = (code.payload as String).split("#");
    if (data.last != password) throw "PASSWORD_IS_INCORRECT";
  },
  errorHandler: (error, p1) {
    return Response.internalServerError(body: {
      "Error": error.toString(),
    }, headers: {
      "Content-Type": "application/json"
    });
  },
);
