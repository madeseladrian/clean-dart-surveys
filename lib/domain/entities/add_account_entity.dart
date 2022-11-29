import 'package:equatable/equatable.dart';

class AddAccountEntity extends Equatable {
  final bool result;

  @override 
  List get props => [result];

  const AddAccountEntity({this.result = false});
}