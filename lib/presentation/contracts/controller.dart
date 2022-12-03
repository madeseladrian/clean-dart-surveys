abstract class Controller<T> {
  Future<Map<String, dynamic>> handle({required T request});
}