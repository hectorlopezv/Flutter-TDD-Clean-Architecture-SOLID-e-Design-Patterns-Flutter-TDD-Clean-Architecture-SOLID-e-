import 'package:equatable/equatable.dart';
import 'package:tdd_clean_patterns_solid/domain/entities/account_entity.dart';

abstract class Authentication {
  Future<AccountEntity> auth(AuthenticationParams params);
}

class AuthenticationParams extends Equatable {
  final String email;
  final String secret;

  AuthenticationParams({required this.email, required this.secret});

  @override
  List get props => [email, secret];
}
