/// Represents an authentication error in the application.
class AppException implements Exception {
  const AppException(this.message);

  final String message;

  @override
  String toString() => message;
}