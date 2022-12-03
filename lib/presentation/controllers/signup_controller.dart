import '../../domain/features/features.dart';
import '../../domain/params/params.dart';

import '../contracts/contracts.dart';
import '../errors/errors.dart';
import '../helpers/helpers.dart';
import '../params/params.dart';


class SignUpController {
  final Validation validation;
  final AddAccount addAccount;

  SignUpController({
    required this.validation,
    required this.addAccount
  });

  Future<dynamic> handle(SignUpControllerRequest request) async {
    try {
      final error = validation.validate(value: request.toMap());
      if (error != null) {
        return badRequest(error);
      }
      final isValid = await addAccount.add(params: AddAccountParams(
        name: request.name,
        email: request.email,
        password: request.password
      ));
      if (!isValid.result) {
        return forbidden(EmailInUseError());
      }
      return noContent();
    } on Exception catch (error) {
      throw ServerError(error.toString());
    }
  }
}

