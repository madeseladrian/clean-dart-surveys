import 'package:equatable/equatable.dart';

class AddAccountRepositoryParams extends Equatable {
  final String? name;
  final String? email;
  final String? password;

  @override 
  List get props => [name, email, password];

  AddAccountRepositoryParams({
    required this.name,
    required this.email, 
    required this.password
  });

  Map<String?, String?> toMap() => {
    "name": name,
    "email": email,
    "password": password
  };
}

class AddAccountRepositoryResult extends Equatable {
  final bool result;

  @override 
  List get props => [result];

  AddAccountRepositoryResult({required this.result});
}