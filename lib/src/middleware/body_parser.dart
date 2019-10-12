import 'dart:convert';
import 'package:dart_express/dart_express.dart';

class BodyParser {
  static RouteMethod json() {
    return (Request req, Response res, Function next) {
      if (req.method == 'POST' && req.headers.contentType.mimeType == 'application/json') {
        convertBodyToJson(req).then((Map<String, dynamic> json) {
          req.body = json;

          next();
        });
      } else {
        next();
      }
    };
  }

  static Future<Map<String, dynamic>> convertBodyToJson(request) async {
    try {
      String content = await utf8.decoder.bind(request).join();

      return jsonDecode(content) as Map<String, dynamic>;
    } catch(e) {
      print(e);

      return null;
    }
  }
}