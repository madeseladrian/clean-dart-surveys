abstract class Hasher {
  Future<String?> getPasswordHash({required String? password});
}