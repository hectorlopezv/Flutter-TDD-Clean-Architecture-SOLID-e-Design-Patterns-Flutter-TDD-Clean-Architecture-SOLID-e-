enum UIError { unexpected, invalidCredentials, requiredField, invalidField, empty }

extension DomainErrorExtension on UIError {
  String get description {
    switch (this) {
      case UIError.invalidCredentials:
        return "credenciais invalidas";
      case UIError.unexpected:
        return "unexpected error";
      case UIError.requiredField:
        return "campo obrigatório";
      default:
        return "algo errado aconteceu, tente novamente em breve ";
    }
  }
}
