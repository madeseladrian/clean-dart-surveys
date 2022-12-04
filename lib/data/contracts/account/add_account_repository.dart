import '../../params/params.dart';

abstract class AddAccountRepository {
  Future<AddAccountRepositoryResult> add({required AddAccountRepositoryParams data});
}