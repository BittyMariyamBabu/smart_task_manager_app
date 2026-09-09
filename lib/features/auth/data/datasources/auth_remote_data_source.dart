import 'package:firebase_auth/firebase_auth.dart';

/// Provides remote authentication operations using Firebase Authentication.
///
/// This class is responsible only for communicating with Firebase Auth.
/// It keeps Firebase-specific implementation details outside the
/// repository and presentation layers.
class AuthRemoteDataSource {
  /// Creates an [AuthRemoteDataSource] with the given Firebase Auth instance.
  AuthRemoteDataSource(this._firebaseAuth);

  final FirebaseAuth _firebaseAuth;

  /// Signs in a user using their email address and password.
  ///
  /// Returns a [UserCredential] containing the authenticated user's
  /// information and authentication credentials.
  ///
  /// Throws a [FirebaseAuthException] when authentication fails.
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