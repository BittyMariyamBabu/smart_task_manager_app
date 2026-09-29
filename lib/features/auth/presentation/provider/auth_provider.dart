import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_task_manger/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:smart_task_manger/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:smart_task_manger/features/auth/domain/repositories/auth_repository.dart';

/// Provides the Firebase Authentication instance.
final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

/// Provides the authentication remote data source.
final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSource(
    ref.read(firebaseAuthProvider),
  );
});

/// Provides the authentication repository.
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    ref.read(authRemoteDataSourceProvider),
  );
});

/// Provides the current Firebase authentication state.
final authStateProvider = StreamProvider<User?>((ref) {
  final repository = ref.read(authRepositoryProvider);
  return repository.authStateChanges;
});

/// Manages authentication state and actions.
final authProvider = NotifierProvider<AuthNotifier, AsyncValue<User?>>(
  AuthNotifier.new,
);

class AuthNotifier extends Notifier<AsyncValue<User?>> {
  late final AuthRepository _repository;

  @override
  AsyncValue<User?> build() {
    _repository = ref.read(authRepositoryProvider);
    return const AsyncData(null);
  }
  
  /// Signs in a user with email and password.
  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();

    try {
      final credential = await _repository.login(
        email: email,
        password: password,
      );

      state = AsyncData(credential.user);
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
    }
  }

  /// Signs up a user with email and password.
  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();

    try {
      final credential = await _repository.signup(
        email: email,
        password: password,
      );

      state = AsyncData(credential.user);
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
    }
  }

  /// Signs out the currently authenticated user.
  Future<void> logOut({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();

    try {
      await _repository.logout();

      state = AsyncData(null);
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
    }
  }

  /// Returns the currently authenticated user.
  User? get currentUser => _repository.currentUser;
}