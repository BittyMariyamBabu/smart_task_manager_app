import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_task_manger/core/router/router_path.dart';
import 'package:smart_task_manger/features/auth/presentation/pages/login_page.dart';
import 'package:smart_task_manger/features/auth/presentation/pages/signup_page.dart';
import 'package:smart_task_manger/features/auth/presentation/provider/auth_provider.dart';

/// Notifies listeners when the authentication state changes.
///
/// Bridges the authentication [Stream] with [ChangeNotifier]
/// so GoRouter can refresh its route logic when the user
/// logs in or logs out.
class AuthRefreshNotifier extends ChangeNotifier {
  /// Starts listening to authentication state changes.
  AuthRefreshNotifier(Stream<User?> authStateChanges) {
    _subscription = authStateChanges.listen(
      // The user value is not needed here.
      // We only need to notify GoRouter that the state changed.
      (_) => notifyListeners(),
    );
  }

  /// Stores the stream subscription so it can be cancelled
  /// when the notifier is no longer needed.
  late final StreamSubscription<User?> _subscription;

  /// Cancels the authentication stream subscription
  /// when the notifier is disposed.
  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

/// Provides the application's GoRouter.
///
/// Creates the authentication refresh notifier and uses it
/// to refresh the router whenever the authentication state changes.
final appRouterProvider = Provider<GoRouter>((ref) {
  // Gets the authentication repository from Riverpod.
  final authRepository = ref.read(authRepositoryProvider);

  // Listens to authentication changes and notifies GoRouter
  // when the user logs in or logs out.
  final authRefreshNotifier = AuthRefreshNotifier(
    authRepository.authStateChanges,
  );

  // Dispose the notifier when this provider is disposed.
  // This also cancels its authentication stream subscription.
  ref.onDispose(authRefreshNotifier.dispose);

  return GoRouter(
    // The first route shown when the application starts.
    initialLocation: AppRouterPath.login,

    // Refreshes GoRouter when the authentication state changes.
    refreshListenable: authRefreshNotifier,

    /// Controls access to routes based on authentication state.
    redirect: (context, state) {
      // Checks whether a Firebase user is currently logged in.
      final isLoggedIn =
          authRepository.currentUser != null;

      // Gets the current route location.
      final location = state.matchedLocation;

      // Checks whether the current route is the login page.
      final isLoginPage =
          location == AppRouterPath.login;

      // Checks whether the current route is the signup page.
      final isSignupPage =
          location == AppRouterPath.signup;

      // If the user is not logged in, allow only login and signup.
      // Redirect all other routes to the login page.
      if (!isLoggedIn &&
          !isLoginPage &&
          !isSignupPage) {
        return AppRouterPath.login;
      }

      // If the user is already logged in, don't allow
      // them to access login or signup again.
      if (isLoggedIn &&
          (isLoginPage || isSignupPage)) {
        return AppRouterPath.dashboard;
      }

      // No redirect is required.
      return null;
    },

    routes: [
      /// Login route.
      routerMethod(
        path: AppRouterPath.login,
        builder: (context, state) {
          return const LoginPage();
        },
      ),

      /// Signup route.
      routerMethod(
        path: AppRouterPath.signup,
        builder: (context, state) {
          return const SignUpPage();
        },
      ),
    ],
  );
});

/// Creates a reusable [GoRoute] with the given path and builder.
///
/// This keeps route definitions short and consistent.
GoRoute routerMethod({
  required String path,
  required Widget Function(
    BuildContext context,
    GoRouterState state,
  ) builder,
}) {
  return GoRoute(
    path: path,
    builder: builder,
  );
}