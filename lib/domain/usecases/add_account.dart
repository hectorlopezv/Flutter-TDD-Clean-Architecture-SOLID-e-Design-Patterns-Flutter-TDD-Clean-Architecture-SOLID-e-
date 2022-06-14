import 'package:equatable/equatable.dart';
import '../entities/account_entity.dart';

abstract class AddAccount {
  Future<AccountEntity> auth(AddAccountParams params);
}

class AddAccountParams extends Equatable {
  final String email;
  final String name;
  final String password;
  final String confirmation;

  AddAccountParams({required this.email, required this.name, required this.password, required this.confirmation});

  @override
  List get props => [email, name, password, confirmation];
}
