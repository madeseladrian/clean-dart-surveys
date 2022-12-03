import 'dart:io';

abstract class Controller<T> {
  Future<HttpResponse> handle(T request);
}