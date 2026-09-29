import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_task_manger/core/router/router_path.dart';
import 'package:smart_task_manger/features/auth/presentation/pages/login_page.dart';
import 'package:smart_task_manger/features/auth/presentation/pages/signup_page.dart';
import 'package:smart_task_manger/features/auth/presentation/provider/auth_provider.dart';
import 'package:smart_task_manger/features/dashboard/presentation/pages/dashboard_page.dart';

/// Notifies listeners when the authentication state changes.
///
/// Bridges the authentication [Stream] with [ChangeNotifier] so that
/// listeners such as GoRouter can refresh when the user logs in or logs out.
class AuthRefreshNotifier extends ChangeNotifier {
  AuthRefreshNotifier(Stream<User?> authStateChanges) {
    _subscription = authStateChanges.listen(
      (_) => notifyListeners(),
    );
  }
  
  /// Keeps the stream subscription so it can be cancelled later.
  late final StreamSubscription<User?> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

final appRouterProvider = Provider<GoRouter>((ref) {
  final authRepository = ref.read(authRepositoryProvider);

  final authRefreshNotifier = AuthRefreshNotifier(
    authRepository.authStateChanges,
  );
  
  // Dispose the auth refresh notifier when this provider is disposed.
  // This stops listening to the authentication state stream.
  ref.onDispose(authRefreshNotifier.dispose);

  return GoRouter(
    initialLocation: AppRouterPath.login,
    // initialLocation: AppRouterPath.splash,

    refreshListenable: authRefreshNotifier,

    redirect: (context, state) {
      final isLoggedIn =
          authRepository.currentUser != null;

      debugPrint('User Logged : $isLoggedIn, Value : ${authRepository.currentUser}');
      
      // tells you the current route.
      final location = state.matchedLocation;

      final isLoginPage =
          location == AppRouterPath.login;

      final isSignupPage =
          location == AppRouterPath.signup;

      // final isSplashPage =
      //     location == AppRouterPath.splash;

      // User is NOT logged in.
      // Allow login, signup and splash.
      if (!isLoggedIn &&
          !isLoginPage &&
          !isSignupPage 
          // &&
          // !isSplashPage
          ) {
        return AppRouterPath.login;
      }

      // User IS logged in.
      // Don't allow logged-in user to stay on login/signup.
      if (isLoggedIn &&
          (isLoginPage || isSignupPage)) {
        return AppRouterPath.dashboard;
      }

      // No redirect.
      return null;
    },

    routes: [
      // routerMethod(
      //   path: AppRouterPath.splash,
      //   builder: (context, state) {
      //     return const SplashPage();
      //   },
      // ),

      routerMethod(
        path: AppRouterPath.login,
        builder: (context, state) {
          return const LoginPage();
        },
      ),

      routerMethod(
        path: AppRouterPath.signup,
        builder: (context, state) {
          return const SignUpPage();
        },
      ),

      routerMethod(
        path: AppRouterPath.dashboard,
        builder: (context, state) {
          return const DashboardPage();
        },
      ),
    ],
  );
});

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