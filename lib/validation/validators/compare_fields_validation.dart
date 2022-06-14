import 'package:equatable/equatable.dart';
import '../../presentation/protocols/validation.dart';
import '../protocols/field_validation.dart';



class CompareFieldsValidation extends Equatable implements FieldValidation {
  @override
  List get props => [field];

  @override
  late final String field;
  final String fieldToCompare;

  CompareFieldsValidation({required this.field, required this.fieldToCompare});

  @override
  ValidationError? validate(Map input) {
    return input[field] != null && input[fieldToCompare]!=null &&  input[field] != input[fieldToCompare] ? null: ValidationError.invalidField;
  }
}
