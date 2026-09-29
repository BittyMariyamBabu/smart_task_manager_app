import 'package:firebase_auth/firebase_auth.dart';

/// Provides authentication operations using Firebase Authentication.
class AuthRemoteDataSource {
  AuthRemoteDataSource(this._firebaseAuth);

  final FirebaseAuth _firebaseAuth;

  /// Signs in a user with email and password.
  ///
  /// Throws [FirebaseAuthException] when authentication fails.
  Future<UserCredential> login({
    required String email,
    required String password,
  }) {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  /// Signs up a user with email and password.
  Future<UserCredential> signUp({
    required String email,
    required String password,
  }) {
    return _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  /// Signs out the currently authenticated user.
  Future<void> logout() {
    return _firebaseAuth.signOut();
  }

  /// Returns the currently authenticated user, if any.
  User? get currentUser => _firebaseAuth.currentUser;

  /// Emits authentication state changes.
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
}