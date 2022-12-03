import 'package:mocktail/mocktail.dart';

import 'package:clean_dart_surveys/data/contracts/contracts.dart';


class HasherSpy extends Mock implements Hasher {
  When mockHasherCall() => 
    when(() => getPasswordHash(password: any(named: 'password')));
  void mockmockHasher({required String? password}) =>
    mockHasherCall().thenAnswer((_) async => password);
}