import 'package:equatable/equatable.dart';
import '../../entities/account_entity.dart';

abstract class AddAccount {
  AddAccount(AddAccountParams addAccountParams);

  Future<AccountEntity> add(AddAccountParams params);
}

class AddAccountParams extends Equatable {
  final String email;
  final String name;
  final String password;
  final String passwordConfirmation;

  AddAccountParams({required this.email, required this.name, required this.password, required this.passwordConfirmation});

  @override
  List get props => [email, name, password, passwordConfirmation];
}

class RemoteAddAccountParams {
   final String email;
  final String name;
  final String password;
  final String passwordConfirmation;

  RemoteAddAccountParams({required this.email, required this.name, required this.password, required this.passwordConfirmation});

  factory RemoteAddAccountParams.fromDomain(AddAccountParams entity) =>
      RemoteAddAccountParams(email: entity.email, password: entity.password, passwordConfirmation: entity.passwordConfirmation, name: entity.name);

  Map toJson() => {"email": email, "password": password, "passwordConfirmation": passwordConfirmation, "name": name};
}
