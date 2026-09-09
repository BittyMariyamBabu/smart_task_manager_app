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
}