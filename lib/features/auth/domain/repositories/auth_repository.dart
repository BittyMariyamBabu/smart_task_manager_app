import 'package:firebase_auth/firebase_auth.dart';

/// Defines authentication operations for the application.
abstract class AuthRepository {
  /// Signs in a user with email and password.
  Future<UserCredential> login({
    required String email,
    required String password,
  });
}