import '../entities/entities.dart';
import '../params/params.dart';

abstract class AddAccount {
  Future<AddAccountEntity> add({required AddAccountParams params});
}