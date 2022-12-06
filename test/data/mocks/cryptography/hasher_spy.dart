import 'package:mocktail/mocktail.dart';

import 'package:clean_dart_surveys/data/contracts/contracts.dart';

class HasherSpy extends Mock implements Hasher {
  When mockHasherCall() => 
    when(() => generateHash(text: any(named: 'text')));
  void mockMockHasher({required String? password}) =>
    mockHasherCall().thenAnswer((_) => 'any_hash');

  void mockMockHasherError({required Exception error}) =>
    mockHasherCall().thenThrow(error);
}