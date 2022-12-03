import 'package:clean_dart_surveys/presentation/helpers/http_helper.dart';

import '../contracts/contracts.dart';
import '../params/params.dart';

class SignUpController {
  final Validation validation;

  SignUpController({required this.validation});

  Future<dynamic> handle(SignUpControllerRequest request) async {
    final error = validation.validate(value: request);
    return badRequest(error);
  }
}

