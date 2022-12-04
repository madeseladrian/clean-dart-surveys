import 'package:equatable/equatable.dart';

class SignUpControllerRequest extends Equatable {
  final String? name;
  final String? email;
  final String? password;
  final String? passwordConfirmation;

  @override
  @override 
  List get props => [name, email, password, passwordConfirmation];

  SignUpControllerRequest({
    required this.name,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
  });

  Map<String?, String?> toMap() => {
    "name": name,
    "email": email,
    "password": password,
    "passwordConfirmation": passwordConfirmation
  };
}