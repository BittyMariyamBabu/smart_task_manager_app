import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_task_manger/core/errors/app_exception.dart';
import 'package:smart_task_manger/core/errors/firebase_errors.dart';
import 'package:smart_task_manger/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:smart_task_manger/features/auth/domain/repositories/auth_repository.dart';

/// Firebase implementation of [AuthRepository].
///
/// Handles authentication through [AuthRemoteDataSource].
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._remoteDataSource);

  final AuthRemoteDataSource _remoteDataSource;

  /// Signs in a user with email and password.
  ///
  /// Converts [FirebaseAuthException] into an [AppException].
  @override
  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    try {
      return await _remoteDataSource.login(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw AppException(mapFirebaseAuthError(e));
    }
  }

  /// Signs up a user with email and password.
  ///
  /// Converts [FirebaseAuthException] into an [AppException].
  @override
  Future<UserCredential> signup({
    required String email,
    required String password,
  }) async {
    try {
      return await _remoteDataSource.signUp(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw AppException(mapFirebaseAuthError(e));
    }
  }

  /// Signs out the currently authenticated user.
  @override
  Future<void> logout() async {
    try {
      await _remoteDataSource.logout();
    } on FirebaseAuthException catch (e) {
      throw AppException(mapFirebaseAuthError(e));
    }
  }

  /// Returns the currently authenticated user, if any.
  @override
  User? get currentUser => _remoteDataSource.currentUser;

  /// Emits authentication state changes.
  @override
  Stream<User?> get authStateChanges =>
      _remoteDataSource.authStateChanges;
}