import 'package:mocktail/mocktail.dart';

import 'package:clean_dart_surveys/presentation/contracts/contracts.dart';

class ValidationSpy extends Mock implements Validation {
  When mockRequestCall() => when(() => validate(value: any(named: 'value')));
  void mockRequest() => mockRequestCall().thenAnswer((_) => null);
  void mockRequestError({required dynamic error}) => 
    mockRequestCall().thenReturn(error);
}