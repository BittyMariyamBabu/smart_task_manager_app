import 'package:firebase_auth/firebase_auth.dart';

import '../datasources/auth_remote_data_source.dart';
import '../../domain/repositories/auth_repository.dart';

/// Firebase-based implementation of [AuthRepository].
///
/// This class connects the domain repository contract with the
/// [AuthRemoteDataSource], which handles communication with Firebase.
class AuthRepositoryImpl implements AuthRepository {
  /// Creates an [AuthRepositoryImpl] with the given remote data source.
  AuthRepositoryImpl(this._remoteDataSource);

  final AuthRemoteDataSource _remoteDataSource;

  /// Signs in the user through the remote data source.
  @override
  Future<UserCredential> login({
    required String email,
    required String password,
  }) {
    return _remoteDataSource.login(
      email: email,
      password: password,
    );
  }
}