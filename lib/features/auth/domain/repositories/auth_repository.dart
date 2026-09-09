import 'package:firebase_auth/firebase_auth.dart';

/// Defines the authentication operations available to the application.
///
/// The domain layer depends on this abstraction instead of depending
/// directly on Firebase Authentication.
abstract class AuthRepository {
  /// Signs in a user using their email address and password.
  ///
  /// Returns the Firebase [UserCredential] after successful authentication.
  ///
  /// Throws an authentication exception when the login fails.
  Future<UserCredential> login({
    required String email,
    required String password,
  });
}