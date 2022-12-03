import '../contracts/contracts.dart';
import '../params/params.dart';

class SignUpController {
  final Validation validation;

  SignUpController({required this.validation});

  Future<dynamic> handle(SignUpControllerRequest request) async {
    validation.validate(value: request);
  }
}

