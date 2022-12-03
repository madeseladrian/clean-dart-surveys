import '../errors/errors.dart';

abstract class Validation {
  ValidationError? validate({required dynamic value});
}