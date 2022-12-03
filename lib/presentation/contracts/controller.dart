abstract class Controller<T> {
  Future<Map<String, dynamic>> handle(T request);
}