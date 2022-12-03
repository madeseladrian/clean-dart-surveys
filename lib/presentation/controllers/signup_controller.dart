import '../contracts/contracts.dart';
import '../errors/errors.dart';
import '../helpers/helpers.dart';
import '../params/params.dart';


class SignUpController {
  final Validation validation;

  SignUpController({
    required this.validation
  });

  Future<dynamic> handle(SignUpControllerRequest request) async {
    try {
      final error = validation.validate(value: request.toMap());
      return badRequest(error);
    } on Exception catch (error) {
      throw ServerError(error.toString());
    }
  }
}

