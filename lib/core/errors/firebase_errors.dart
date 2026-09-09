 import 'package:firebase_auth/firebase_auth.dart';

/// Converts Firebase authentication error codes into user-friendly
/// application messages.
String mapFirebaseAuthError(FirebaseAuthException exception) {
  switch (exception.code) {
    case 'invalid-email':
      return 'Please enter a valid email address.';

    case 'user-not-found':
      return 'No account found with this email.';

    case 'wrong-password':
      return 'Incorrect password.';

    case 'invalid-credential':
      return 'Invalid email or password.';

    case 'user-disabled':
      return 'This account has been disabled.';

    case 'too-many-requests':
      return 'Too many attempts. Please try again later.';

    case 'network-request-failed':
      return 'Please check your internet connection.';

    default:
      return 'Unable to sign in. Please try again.';
  }
}