import 'package:clean_dart_surveys/domain/entities/add_account_entity.dart';
import 'package:mocktail/mocktail.dart';

import 'package:clean_dart_surveys/domain/params/params.dart';
import 'package:clean_dart_surveys/domain/features/features.dart';


class AddAccountSpy extends Mock implements AddAccount {
  When mockAddAccountCall() => when(() => add(params: any(named: 'params')));
  void mockAddAccount({required AddAccountParams params}) =>
    mockAddAccountCall().thenAnswer((_) async => AddAccountEntity(result: true));
  void mockAddAccountError({required Error error}) => 
    mockAddAccountCall().thenAnswer((_) async => AddAccountEntity(result: false));
}