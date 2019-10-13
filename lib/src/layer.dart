import 'dart:io';
import 'middleware/init.dart';
import 'package:dart_express/src/route.dart';

class Layer {
  String _path;
  String method;
  RouteMethod handle;
  Route route;
  String name;

  String get path => this._path ?? this.route.path;

  Layer(this._path, { this.method, this.handle, this.route, this.name }) {
    this.name = this.name ?? '<anonymous>';
  }

  match(pathToCheck, methodToCheck) {
    if (methodToCheck != this.method || this.method == null) {
      return false;
    }

    if (this.route != null && this.route.path == pathToCheck) {
      return true;
    } else if (this.name == Middleware.name) {
      return true;
    }

    return false;
  }

  handleRequest(HttpRequest req, HttpResponse res, Next next) {
    this.handle(req, res, next);
  }

  @override
  String toString() {
    return 'Layer: { path: ${this.route.path} }';
  }
}
