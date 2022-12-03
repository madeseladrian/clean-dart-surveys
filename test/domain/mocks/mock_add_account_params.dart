import 'package:faker/faker.dart';

import 'package:clean_dart_surveys/domain/params/params.dart';


AddAccountParams mockAddAccountParams() => AddAccountParams(
  name: faker.person.name(),
  email: faker.internet.email(),
  password: faker.internet.password()
);
