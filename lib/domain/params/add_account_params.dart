import 'package:equatable/equatable.dart';

class AddAccountParams extends Equatable {
  final String? name;
  final String? email;
  final String? password;

  @override 
  List get props => [name, email, password];

  AddAccountParams({this.name, this.email, this.password});
}