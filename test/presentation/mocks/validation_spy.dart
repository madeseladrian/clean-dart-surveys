import 'package:mocktail/mocktail.dart';

import 'package:clean_dart_surveys/presentation/contracts/contracts.dart';

class ValidationSpy extends Mock implements Validation {
  When mockRequestCall() => when(() async => validate(value: any(named: 'value')));
  void mockRequest() => mockRequestCall().thenAnswer((_) => null);
  void mockRequestError({required Error error}) => 
    mockRequestCall().thenReturn(error);
  void mockRequestThrowsError({required Exception error}) =>
    mockRequestCall().thenThrow(error);
}