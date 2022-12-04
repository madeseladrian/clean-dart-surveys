import 'package:faker/faker.dart';

import 'package:clean_dart_surveys/data/params/params.dart';


AddAccountRepositoryParams mockAddAccountRepository({
  String? name, 
  String? email, 
  String? password
}) => AddAccountRepositoryParams(
  name: name ?? faker.person.name(),
  email: email ?? faker.internet.email(),
  password: password ?? faker.internet.password()
);
