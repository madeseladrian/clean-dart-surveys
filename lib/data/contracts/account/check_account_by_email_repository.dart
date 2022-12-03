abstract class CheckAccountByEmailRepository {
  Future<bool> checkByEmail({required String? email});
}