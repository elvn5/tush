class UserNotConfirmedDomainException implements Exception {
  final String message;
  UserNotConfirmedDomainException(this.message);
  @override
  String toString() => message;
}
