class SignUpControllerRequest {
  final String? name;
  final String? email;
  final String? password;
  final String? passwordConfirmation;

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