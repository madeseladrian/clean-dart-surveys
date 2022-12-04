import 'package:mocktail/mocktail.dart';

import 'package:clean_dart_surveys/data/contracts/contracts.dart';
import 'package:clean_dart_surveys/data/params/params.dart';

class AddAccountRepositorySpy extends Mock implements AddAccountRepository {
  When mockAddAccountRepositoryCall() => when(() => add(data: any(named: 'data')));

  void mockAddAccountRepository() => 
    mockAddAccountRepositoryCall().thenAnswer((_) async => 
      AddAccountRepositoryResult(result: false));
}