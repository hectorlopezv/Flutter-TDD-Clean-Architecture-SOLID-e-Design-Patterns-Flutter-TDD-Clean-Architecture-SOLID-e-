import 'package:equatable/equatable.dart';
import '../../presentation/protocols/validation.dart';
import '../protocols/field_validation.dart';

class MinLengthValidation extends Equatable implements FieldValidation {
  @override
  List get props => [field];

  @override
  late final String field;
  final int size;

  MinLengthValidation({required this.field, required this.size});

  @override
  ValidationError? validate(Map input) {
    return input[field].length >= size? null: ValidationError.invalidField;
  }
}
