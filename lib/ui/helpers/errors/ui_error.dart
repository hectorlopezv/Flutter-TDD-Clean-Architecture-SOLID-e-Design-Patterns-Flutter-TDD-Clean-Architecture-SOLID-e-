enum UIError { unexpected, invalidCredentials, requiredField, invalidField, empty, emailInUse }

extension DomainErrorExtension on UIError {
  String get description {
    switch (this) {
      case UIError.invalidCredentials:
        return "credenciais invalidas";
      case UIError.unexpected:
        return "unexpected error";
      case UIError.requiredField:
        return "campo obrigatório";
      case UIError.emailInUse:
        return "email in use";
      default:
        return "algo errado aconteceu, tente novamente em breve ";
    }
  }
}
