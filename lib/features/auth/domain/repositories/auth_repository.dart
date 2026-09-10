import 'package:firebase_auth/firebase_auth.dart';

/// Defines authentication operations for the application.
abstract class AuthRepository {
  /// Signs in a user with email and password.
  Future<UserCredential> login({
    required String email,
    required String password,
  });

  /// Signs up a user with email and password.
  Future<UserCredential> signup({
    required String email,
    required String password,
  });

  /// Signs out the currently authenticated user.
  Future<void> logout();

  /// Returns the currently authenticated user, if any.
  User? get currentUser;
  
  /// Emits authentication state changes.
  Stream<User?> get authStateChanges;
}