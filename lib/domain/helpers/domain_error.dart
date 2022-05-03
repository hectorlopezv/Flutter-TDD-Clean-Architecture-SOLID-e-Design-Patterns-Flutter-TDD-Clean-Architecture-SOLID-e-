enum DomainError { unexpected, invalidCredentials }

extension DomainErrorExtension on DomainError {
  String get description {
    switch (this) {
      case DomainError.invalidCredentials:
        return "credenciais invalidas";
      case DomainError.unexpected:
        return "unexpected error";
      default:
        return "";
    }
  }
}
